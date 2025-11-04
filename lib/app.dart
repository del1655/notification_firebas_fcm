import 'package:flutter/material.dart';
import 'features/home/home_page.dart';
import 'core/notifications/notification_service.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // Inicializar notificaciones
    NotificationService.initialize(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Demo FCM Flutter',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: const HomePage(),
    );
  }
}
