import 'package:flutter/material.dart';
import 'package:jaimito_app/ui/pantallas/pnt_principal.dart';
import 'package:jaimito_app/ui/pantallas/pnt_principal_inventario.dart';
import 'package:jaimito_app/ui/utils/colores.dart';

class PntMenu extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {

                  Navigator.push(context, MaterialPageRoute(builder: (_) => PntPrincipalInventario()));

                },
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color> [
                        Colors.red.shade400,
                        Colors.red.shade700
                      ]
                    )
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget> [
                      const Icon(
                        Icons.add_chart,
                        color: Colors.white,
                        size: 48,
                      ),

                      const SizedBox(
                        height: 18,
                      ),

                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Inventario',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 30
                          ),
                        ),
                      ),
                    ] 
                  ),
                ),
              ),
            ),

            Expanded(
              child: GestureDetector(
                onTap: () {

                  Navigator.push(context, MaterialPageRoute(builder: (_) => PntPrincipal()));

                },
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color> [
                        Colors.blue.shade700,
                        primario
                      ]
                    )
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.email,
                        color: Colors.white,
                        size: 48,
                      ),

                      const SizedBox(
                        height: 18,
                      ),

                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Correspondencia',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 30
                          ),
                        ),
                      )
                    ],
                  )
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}