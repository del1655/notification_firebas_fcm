# 📱 Demo FCM - Flutter Firebase Cloud Messaging

Un proyecto de ejemplo en **Flutter** que integra **Firebase Cloud Messaging (FCM)** para recibir notificaciones push en Android.  
Ideal para aprender a manejar notificaciones y la configuración de Firebase en Flutter.

---

## ✨ Características

- ✅ Integración con **Firebase Cloud Messaging (FCM)**
- ✅ Manejo de mensajes en **background** y **foreground**
- ✅ Uso de **API Keys seguras** mediante `.env`
- ✅ Estructura lista para agregar más servicios de Firebase (Auth, Firestore, etc.)

---

## 🛠 Requisitos

- Flutter ≥ 3.x
- Android Studio o VS Code
- Proyecto Firebase con FCM configurado
- Archivo `google-services.json` en `android/app/` (no subir al repo)

---

## 🚀 Instalación y uso

1. **Clonar el repositorio**:

```bash
git clone https://github.com/tuusuario/demo_fcm.git
cd demo_fcm


````

2. **Instalar dependencias**:

```bash
flutter pub get
```

3. **Crear archivo `.env`** en la raíz del proyecto:

```env
FIREBASE_API_KEY_ANDROID=TU_NUEVA_API_KEY
```

> Reemplaza `TU_NUEVA_API_KEY` con tu clave de Firebase.

4. **Agregar `google-services.json`** en `android/app/` (no subir al repo)

5. **Ejecutar la app**:

```bash
flutter run
```

---

## 📂 Estructura del proyecto

* `lib/firebase_options.dart` → Configuración de Firebase usando `.env`
* `lib/firebase_messaging_handler.dart` → Manejo de notificaciones en background/foreground
* `lib/main.dart` → Inicialización de Firebase y ejecución de la app

---

## 🔐 Seguridad

* Las **API Keys** de Firebase **no deben subirse** al repositorio.
* Se usan variables de entorno (`.env`) para mantenerlas seguras.
* `google-services.json` está ignorado en Git (`.gitignore`).

---

## 📚 Recursos útiles

* [Documentación oficial de Flutter](https://docs.flutter.dev/)
* [Guía oficial de Firebase Cloud Messaging](https://firebase.google.com/docs/cloud-messaging)
* [FlutterFire CLI](https://firebase.flutter.dev/docs/cli)



