import 'package:flutter/material.dart';
import 'package:jaimito_app/core/modelos/cls_correspondencia.dart';
import 'package:jaimito_app/core/modelos/cls_emplazamiento.dart';
import 'package:jaimito_app/ui/pantallas/pnt_informacion_correspondencia.dart';
import 'package:jaimito_app/ui/utils/cls_conversor_fecha.dart';
import 'package:jaimito_app/ui/utils/colores.dart';

class PerTarjetaEmplazamiento extends StatelessWidget {
 
  ClsEmplazamiento emplazamiento;
  Function onPressed;

  PerTarjetaEmplazamiento({this.emplazamiento, @required this.onPressed});
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {

            this.onPressed();

          },
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 18
            ),
            padding: EdgeInsets.only(
              left: 12,
              right: 12,
              bottom: 6,
              top: 12
            ),
            width: double.infinity,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  offset: Offset(3, 3),
                  color: Colors.black12,
                  blurRadius: 3,
                  spreadRadius: 3
                )
              ],
              // color: cardColor,
              color: inventarioColor.withOpacity(0.8),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 12
                  ),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12)
                    )
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Denominacion: ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          Expanded(
                            child: Text(
                              emplazamiento.empDenominacion,
                              // division.divDetalles,
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            )
                          )
                        ],
                      )
                    ],
                  ),
                ),

                const SizedBox(height: 8),
              ],
            ),
          ),
        ),

        Positioned(
          top: 0,
          left: 10,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 4
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.5),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Theme.of(context).primaryColor, width: 2)
            ),
            child: Text(
              emplazamiento.empCodigo,
              // division.divCodigo,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: claro
              ),
            ),
          ),
        ),
      ],
    );
  }
}