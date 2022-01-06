import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';

class NotificacionesPushProveedor {

  static final NotificacionesPushProveedor instancia = NotificacionesPushProveedor._interno();

  factory NotificacionesPushProveedor() => instancia;

  NotificacionesPushProveedor._interno();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  static final _mensajesStreamControlador = StreamController<String>.broadcast();

  Stream<String> get mensajesStream => _mensajesStreamControlador.stream;

  Stream<String> get nuevoFCMStream => _firebaseMessaging.onTokenRefresh;

  static Future<void> onBackgroundMessage(RemoteMessage message) async {
    if (message.data.isNotEmpty) {
      // Handle data message
      var data = message.data;

      print(data);
    }

    if (message.notification.body.isNotEmpty) {
      // Handle notification message
      print("Notification");
      final dynamic notificacion = message.notification.body;
    }
    // Or do other work.
    _mensajesStreamControlador.sink.add(message.toString());

    print("Mensaje");
    print(message.toString());
    print("Fin del mensaje");
  }  

  Future<String> fcmToken() async {
    return (await _firebaseMessaging.getToken());
  } 

  iniciarNotificaciones() async {
    
    await _firebaseMessaging.requestPermission();

    final token = await _firebaseMessaging.getToken();

    print("FCM Token:");
    print(token);
 
    FirebaseMessaging.onMessage.listen(onMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(onLaunch);
    FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);
  }


  Future<dynamic> onMessage(RemoteMessage message) async {
    
    // Cuando la aplicación está abierta
    print("On message");
    print("Mensaje");
    var data = message.data;
    var notificacion = message.notification;
    print(notificacion.title);
    print(notificacion.body);

    _mensajesStreamControlador.sink.add(message.toString());

  }  

  Future<dynamic> onLaunch(RemoteMessage message) async {
    
    // Cuando la aplicación se abre
    print("On launch");
    print("Mensaje");
    var data = message.data;
    _mensajesStreamControlador.sink.add(message.toString());


  }

  Future<dynamic> onResume(RemoteMessage message) async {
    
    // Cuando se resume del background
    print("On resume");
    print("Mensaje");
    var data = message.data;

    print(data);

    _mensajesStreamControlador.sink.add(message.toString());

  }  

  dispose() {
    _mensajesStreamControlador?.close();
  }

}

NotificacionesPushProveedor notificacionesProveedor = NotificacionesPushProveedor();