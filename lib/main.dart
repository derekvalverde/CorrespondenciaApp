import 'package:flutter/material.dart';
import 'package:jaimito_app/ui/pantallas/pnt_informacion_correspondencia.dart';
import 'package:jaimito_app/ui/pantallas/pnt_login.dart';
import 'package:jaimito_app/ui/pantallas/pnt_principal.dart';
import 'package:jaimito_app/ui/pantallas/pnt_splash.dart';
import 'package:jaimito_app/ui/utils/cls_notificaciones_push_proovedor.dart';
import 'package:jaimito_app/ui/utils/colores.dart';
import 'package:firebase_core/firebase_core.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  final notificacionesProveedor = new NotificacionesPushProveedor();
  await notificacionesProveedor.iniciarNotificaciones();
  runApp(MyApp());
} 
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primario,
        accentColor: accent,
        scaffoldBackgroundColor: scaffoldColor,
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(
            fontSize: 16
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: primario, width: 10)
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(width: 5)
          )
        ),
        textTheme: TextTheme(
          headline6: TextStyle(
            color: primario, 
            fontWeight: FontWeight.bold,
            fontSize: 24
          )
        )
      ),
      title: 'Correspondencia Inti',
      // home: PntLogin(),
      // home: PntInformacionCorrespondencia(),
      home: PntSplash()
    );
  }
}