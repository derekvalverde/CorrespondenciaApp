import 'package:flutter/material.dart';
import 'package:jaimito_app/core/modelos/cls_correspondencia.dart';
import 'package:jaimito_app/core/modelos/cls_division.dart';
import 'package:jaimito_app/ui/pantallas/pnt_informacion_correspondencia.dart';
import 'package:jaimito_app/ui/utils/cls_conversor_fecha.dart';
import 'package:jaimito_app/ui/utils/colores.dart';
import 'package:jaimito_app/ui/widgets/per_tarjeta_detalle.dart';

class PerTarjetaCorrespondencia extends StatelessWidget {
 
  // ClsDivision division;
  ClsCorrespondencia correspondencia;

  PerTarjetaCorrespondencia({this.correspondencia});
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(context,
              MaterialPageRoute(builder: (_) => PntInformacionCorrespondencia(
                correspondencia: this.correspondencia)));
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
              color: Color(0xff48cfb4).withOpacity(0.8),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Remitente: ",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      correspondencia.corRemitente,
                      // division.corRemitente,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                      ),
                    )
                  ],
                ),

                const SizedBox(height: 8),

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
                            "Descripcion: ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          Expanded(
                            child: Text(
                              correspondencia.cdeDetalles,
                              // division.divDetalles,
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            )
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12)
                    )
                  ),
                  child: Text(
                    ClsConversorFecha.convertirParaLecturaYHora(correspondencia.cdeFechaIni),
                    // ClsConversorFecha.convertirParaLecturaYHora(division.divFechaIni),
                    style: TextStyle(
                      color: claro,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
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
              correspondencia.cdeCodigo,
              // division.divCodigo,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: claro
              ),
            ),
          ),
        ),

        Positioned(
          top: 0,
          right: 10,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 4
            ),
            decoration: BoxDecoration(
              color: correspondencia.cdeEstado == "PE"
                ? Colors.redAccent
                : correspondencia.cdeEstado == "RG"
                  ? Colors.amber
                  : Colors.green,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Theme.of(context).primaryColor, width: 2)
            ),
            child: Text(
              correspondencia.cdeEstado,
              // division.divestado,
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