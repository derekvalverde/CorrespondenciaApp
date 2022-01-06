import 'package:flutter/material.dart';
import 'package:jaimito_app/core/modelos/cls_correspondencia_detallle.dart';
import 'package:jaimito_app/core/modelos/cls_division_informacion.dart';
import 'package:jaimito_app/ui/utils/cls_conversor_fecha.dart';
import 'package:jaimito_app/ui/utils/colores.dart';

class PerTarjetaDetalle extends StatelessWidget {
  
  ClsCorrespondenciaDetalle detalle;

  PerTarjetaDetalle({
    @required this.detalle  
  });
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10
          ),
          padding: EdgeInsets.all(12),
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
                    "Usuario: ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Expanded(
                    child: Text(
                      detalle.nombre,
                      textAlign: TextAlign.center,
                      // informacion.nombre,
                      // informacion.nombre,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                      ),
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
                  borderRadius: BorderRadius.circular(12)
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Ubicación: ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        ),

                        Expanded(
                          child: Text(
                            detalle.ubicacion,
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          )
                        )
                      ],
                    )
                  ],
                ),
              ),

              const SizedBox(height: 8),

              Container(
                width: double.infinity,
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(12)
                ),
                child: Text(
                  // ClsConversorFecha.convertirParaLecturaYHora(informacion.fecha),
                  ClsConversorFecha.convertirParaLecturaYHora(detalle.fecha),
                  style: TextStyle(
                    color: claro,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}