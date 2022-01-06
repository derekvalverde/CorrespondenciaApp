import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jaimito_app/ui/pantallas/pnt_login.dart';
import 'package:jaimito_app/ui/utils/colores.dart';
import 'package:jaimito_app/ui/utils/custom_route.dart';

class PntSplash extends StatefulWidget {  
  @override
  _PntSplashState createState() => _PntSplashState();
}

class _PntSplashState extends State<PntSplash> {
  
  bool animacionActivada = false;

  @override
  void initState() { 
    super.initState();
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp
      ]);

      Timer(const Duration(milliseconds: 1500), () {
        setState(() {
          animacionActivada = true;
        });
      });

      Timer(const Duration(seconds: 3), () {
        Navigator.of(context).pushAndRemoveUntil(AppPageRoute(builder: (BuildContext context) => PntLogin()), (route) => false);
      });      
    });

  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinPerfect(
          duration: const Duration(seconds: 1),
          animate: animacionActivada,
          child: Hero(
            tag: 'logo-app',
            child: Container(
              height: 160,
              width: 160,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/imagenes/logo.jpg")
                ),
                color: claro,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(3, 3),
                    color: Colors.black12,
                    spreadRadius: 3,
                    blurRadius: 3
                  )
                ]
              ),
            ),
          ),
        ),
      ),
    );
  }
}