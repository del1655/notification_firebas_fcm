import 'dart:io';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class NotificationService {
  static final _firebaseMessaging = FirebaseMessaging.instance;
  static final _localNotificationsPlugin = FlutterLocalNotificationsPlugin();

  // Inicialización del servicio
  static Future<void> initialize(BuildContext context) async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);

    await _localNotificationsPlugin.initialize(initializationSettings);

    // Solicitar permisos
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    log('🔔 Permiso de notificaciones: ${settings.authorizationStatus}');

    // Foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log(' Notificación foreground: ${message.notification?.title}');
      showLocal(message: message);
    });

    // Cuando se abre la app desde notificación
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log(' App abierta desde notificación: ${message.data}');
    });

    // Token
    String? token = await _firebaseMessaging.getToken();
    log(' Token FCM: $token');
  }

  // Mostrar notificación local con verificación de imagen
  static Future<void> showLocal({RemoteMessage? message, String? title, String? body}) async {
    BigPictureStyleInformation? bigPicture;

    // Si viene mensaje de Firebase
    if (message != null) {
      final notification = message.notification;
      final android = message.notification?.android;

      title ??= notification?.title;
      body ??= notification?.body;

      if (android?.imageUrl != null) {
        try {
          final url = Uri.parse(android!.imageUrl!);
          log(' Intentando descargar imagen: ${url.toString()}');

          final response = await http.get(url);

          if (response.statusCode == 200) {
            final dir = await getTemporaryDirectory();
            final filePath = '${dir.path}/notification_image.jpg';
            final file = File(filePath);
            await file.writeAsBytes(response.bodyBytes);
            log(' Imagen descargada y guardada en: $filePath');

            bigPicture = BigPictureStyleInformation(
              FilePathAndroidBitmap(filePath),
              contentTitle: title,
              summaryText: body,
            );
          } else {
            log('⚠ Error al descargar imagen: StatusCode ${response.statusCode}');
          }
        } catch (e) {
          log(' Excepción al descargar imagen: $e');
        }
      } else {
        log(' No viene URL de imagen en el mensaje');
      }
    }

    // Detalles de la notificación
    final AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'default_channel',
      'Notificaciones',
      channelDescription: 'Canal por defecto para notificaciones',
      importance: Importance.high,
      priority: Priority.high,
      styleInformation: bigPicture,
    );

    final NotificationDetails platformDetails =
    NotificationDetails(android: androidDetails);

    await _localNotificationsPlugin.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title,
      body,
      platformDetails,
    );
  }
}
