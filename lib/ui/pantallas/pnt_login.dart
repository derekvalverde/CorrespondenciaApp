import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:jaimito_app/core/blc_sesion_usuario.dart';
import 'package:jaimito_app/core/servicios/jaimito_api.dart';
import 'package:jaimito_app/ui/pantallas/pnt_menu.dart';
import 'package:jaimito_app/ui/pantallas/pnt_principal.dart';
import 'package:jaimito_app/ui/utils/colores.dart';
import 'package:jaimito_app/ui/utils/espaciados.dart';
import 'package:jaimito_app/ui/utils/show_loading.dart';
import 'package:jaimito_app/ui/widgets/per_boton_icono.dart';

class PntLogin extends StatefulWidget {
  
  @override
  _PntLoginState createState() => _PntLoginState();
}

class _PntLoginState extends State<PntLogin> {
  BlcSesionUsuario _blcSesionUsuario = BlcSesionUsuario();

  void _ingresarAlSistema(context) async {
    String usuario = _usuarioControlador.text ?? '';
    String contrasena = _contrasenaControlador.text ?? '';
  
    try {
      showLoading(context);

      await _blcSesionUsuario.iniciarSesion(
        usuario: usuario,
        contrasena: contrasena
      );

      Navigator.pop(context);
      
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => PntPrincipal()
        ),
        (route) => false
      );
    } catch (error) {
      print(error);
      Navigator.pop(context);

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text("Usuario o contraseña incorrecto"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context), 
                child: Text("Aceptar")
              )
            ],
          );
        }
      );
    }
  }

  TextEditingController _usuarioControlador;
  TextEditingController _contrasenaControlador;

  @override
  void initState() { 
    super.initState();
    _usuarioControlador = TextEditingController();
    _contrasenaControlador = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Transform.rotate(
        angle: math.pi,
        child: BotonIcono(
          mOnPressed: () {
            _ingresarAlSistema(context);
          },
          mIcono: Icon(
            Icons.arrow_back, 
            size: 40,
            color: Colors.white,
          )
        ),
      ),
      body: Container(
        padding: espaciadoPantalla,
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: 'logo-app',
              child: Container(
                margin: EdgeInsets.only(
                  bottom: 42
                ),
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: claro,
                  borderRadius: BorderRadius.circular(18),
                  image: DecorationImage(
                    image: AssetImage("assets/imagenes/logo.jpg")
                  ),
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

            const SizedBox(height: 42),

            TextField(
              controller: _usuarioControlador,
              onChanged: (value) {
                print(value);
              },
              decoration: InputDecoration(
                hintText: "Usuario",
                labelText: "Usuario"
              ),
            ),
            
            const SizedBox(height: 32),

            TextField(
              controller: _contrasenaControlador,
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Contraseña",
                labelText: "Contraseña",
              ),
            ),
          ] 
        ),
      )
    );
  }
}

