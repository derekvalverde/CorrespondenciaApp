import 'package:flutter/material.dart';
import 'package:jaimito_app/core/blc_correspondencias.dart';
import 'package:jaimito_app/core/modelos/cls_correspondencia.dart';
import 'package:jaimito_app/core/modelos/cls_correspondencia_detallle.dart';
import 'package:jaimito_app/core/blc_divisiones.dart';
import 'package:jaimito_app/core/modelos/cls_division.dart';
import 'package:jaimito_app/core/modelos/cls_division_informacion.dart';
import 'package:jaimito_app/core/servicios/jaimito_api.dart';
import 'package:jaimito_app/ui/utils/colores.dart';
import 'package:jaimito_app/ui/utils/espaciados.dart';
import 'package:jaimito_app/ui/utils/show_loading.dart';
import 'package:jaimito_app/ui/widgets/per_boton_redondeado.dart';
import 'package:animate_do/animate_do.dart';
import 'package:jaimito_app/ui/widgets/per_tarjeta_detalle.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:permission_handler/permission_handler.dart';
import 'package:toast/toast.dart';

class PntInformacionCorrespondencia extends StatefulWidget {
  
  ClsCorrespondencia correspondencia;

  PntInformacionCorrespondencia({
    @required this.correspondencia
  });

  @override
  _PntInformacionCorrespondenciaState createState() => _PntInformacionCorrespondenciaState();
}

class _PntInformacionCorrespondenciaState extends State<PntInformacionCorrespondencia> {
  _escanearCodigo() async {
    PermissionStatus estadoPermiso = await Permission.camera.status;
    // 
    if (estadoPermiso == PermissionStatus.denied) {
      await Permission.camera.request();
    } 
// 
    estadoPermiso = await Permission.camera.request();

    if (estadoPermiso == PermissionStatus.granted) {
      String resultadoEscaneo = await scanner.scan();
      
      if (resultadoEscaneo != null) {
        try {
          showLoading(context);
          await ClsJaimitoApi().apiLectorCelular(
            lectorTipo: 3,
            codigo: widget.correspondencia.cdeCodigo,
            archivero: resultadoEscaneo
          );
          await blcCorrespondencias.iniciarCorrespondencias();
          Navigator.pop(context); 
  
          setState(() {
              
          });

          Toast.show(
            "Paquete Archivado con Éxito", context,
            backgroundColor: Colors.green.shade800,
            textColor: Colors.white,
            gravity: Toast.BOTTOM
          );
        } catch (error) {
          print("Error: ${error.toString()}");
          Toast.show(
            "Hubo un problema al recepcionar el paquete", context,
            backgroundColor: Colors.redAccent,
            textColor: Colors.white,
            gravity: Toast.BOTTOM
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Información 022", style: Theme.of(context).textTheme.headline6),
        centerTitle: true,
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
      ),
      floatingActionButton: widget.correspondencia.cdeEstado == "PE"
        ? Container()
        : PerBotonRedondeado(
            mOnPressed: _escanearCodigo, 
            // mOnPressed: () async {
              // await ClsJaimitoApi().apiLectorCelular(
                // lectorTipo: 3,
                // codigo: widget.correspondencia.cdeCodigo,
                // archivero: "0155"
              // );
            // }, 
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Archivar",
                  style: TextStyle(
                    color: claro,
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(width: 12),
                Icon(Icons.download_done_outlined, color: Colors.white, size: 40)
              ],
            )
          ),
      body: SafeArea(
        child: Padding(
          padding: espaciadoPantalla,
          child: Column(
            children: [
              Expanded(
                child: FutureBuilder(
                  future: ClsJaimitoApi().apiCorrespondenciaDetalleInformacionCelular(divId: this.widget.correspondencia.cdeId),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<ClsCorrespondenciaDetalle> informaciones = snapshot.data;

                      if (informaciones.isEmpty)
                        return Center(
                          child: Text("Sin correspondencia"),
                        );

                      return ListView.builder(
                        itemCount: informaciones.length,
                        itemBuilder: (context, index) {
                          return ZoomIn(
                            duration: const Duration(milliseconds: 750),
                            delay: Duration(milliseconds: index * 25),
                            child: PerTarjetaDetalle(
                              detalle: informaciones.elementAt(index),
                            ),
                          );
                        },
                      );
                    }

                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                )
              )
            ],
          ),
        ),
      )
    );
  }
}