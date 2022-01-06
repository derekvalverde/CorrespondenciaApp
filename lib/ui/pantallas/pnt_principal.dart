import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jaimito_app/core/blc_correspondencias.dart';
import 'package:jaimito_app/core/blc_divisiones.dart';
import 'package:jaimito_app/core/modelos/cls_correspondencia.dart';
import 'package:jaimito_app/core/modelos/cls_division.dart';
import 'package:jaimito_app/core/servicios/jaimito_api.dart';
import 'package:jaimito_app/ui/utils/cls_conversor_fecha.dart';
import 'package:jaimito_app/ui/utils/colores.dart';
import 'package:jaimito_app/ui/utils/espaciados.dart';
import 'package:jaimito_app/ui/utils/show_loading.dart';
import 'package:jaimito_app/ui/widgets/per_boton_redondeado.dart';
import 'package:jaimito_app/ui/widgets/per_tarjeta_correspondencia.dart';
import 'package:animate_do/animate_do.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:permission_handler/permission_handler.dart';
import 'package:toast/toast.dart';

class PntPrincipal extends StatefulWidget {
  
  @override
  _PntPrincipalState createState() => _PntPrincipalState();
}

class _PntPrincipalState extends State<PntPrincipal> {
  
  bool recojoRecepcionActivo = false;
  final _buscadorControlador = TextEditingController();

  @override
  void initState() { 
    super.initState();
    blcCorrespondencias.iniciarCorrespondencias();
  }

  _escanearCodigo() async {
    PermissionStatus estadoPermiso = await Permission.camera.status;

    if (estadoPermiso == PermissionStatus.denied) {
      await Permission.camera.request();
    } 

    estadoPermiso = await Permission.camera.request();

    if (estadoPermiso == PermissionStatus.granted) {
      String resultadoEscaneo = await scanner.scan();

      print("RESULTADO ESCANEO: $resultadoEscaneo");

      if (resultadoEscaneo != null) {
        try {
          showLoading(context);
          await ClsJaimitoApi().apiLectorCelular(
            lectorTipo: recojoRecepcionActivo ? 1 : 2,
            codigo: resultadoEscaneo,
            archivero: ""
          );
          await blcCorrespondencias.iniciarCorrespondencias();
          Navigator.pop(context);
  
          Toast.show(
            "Paquete Recepcionado con Éxito", context,
            backgroundColor: Colors.green.shade800,
            textColor: Colors.white,
            gravity: Toast.BOTTOM,
            duration: Toast.LENGTH_LONG
          );
        } catch (error) {
          Toast.show(
            "Hubo un problema al recepcionar el paquete", context,
            backgroundColor: Colors.redAccent,
            textColor: Colors.white,
            gravity: Toast.BOTTOM,
            duration: Toast.LENGTH_LONG
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: PerBotonRedondeado(
        mOnPressed: _escanearCodigo,
        // mOnPressed: () async {
          // await ClsJaimitoApi().apiLectorCelular(
            // lectorTipo: recojoRecepcionActivo ? 1 : 2,
            // codigo: "88888",
            // archivero: ""
          // );
        // }, 
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Recepcionar",
              style: TextStyle(
                color: claro,
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(width: 12),
            Icon(Icons.camera_alt, color: Colors.white, size: 40)
          ],
        )
      ),
      body: SafeArea(
        child: Padding(
          padding: espaciadoPantalla,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Lista de Correspondencia", style: Theme.of(context).textTheme.headline6),
              
              const SizedBox(height: 12),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextField(
                      controller: _buscadorControlador,
                      decoration: InputDecoration(
                        hintText: "Buscar correspondencia",
                        suffixIcon: Icon(Icons.search),
                      ),
                      onChanged: (a) {
                        setState(() {
                            
                        });
                      },
                      onSubmitted: (valor) {
                        FocusScope.of(context).unfocus();
                      },
                    ),
                  ),
                  
                  const SizedBox(width: 12),

                  Container(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CupertinoSwitch(
                          value: recojoRecepcionActivo, 
                          onChanged: (valor) {
                            setState(() {
                              recojoRecepcionActivo = valor;                   
                            });
                          },
                          activeColor: Colors.redAccent,
                          trackColor: claro.withOpacity(0.4),
                        ),
                        Text(
                          "Recojo de\nrecepción",
                          style: TextStyle(color: claro),
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(12)
                    ),
                  )
                ],
              ),

              const SizedBox(height: 12),

              Expanded(
                child: StreamBuilder(
                  stream: blcCorrespondencias.correspondenciasStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<ClsCorrespondencia> correspondencias = snapshot.data;
                      
                      List<ClsCorrespondencia> correspondenciasFiltrado = [];
                      String busqueda = _buscadorControlador.text ?? "";
                      busqueda = busqueda.toLowerCase();

                      correspondencias.forEach((correspondencia) {
                        if (correspondencia.cdeCodigo.toLowerCase().contains(busqueda)) correspondenciasFiltrado.add(correspondencia);
                        else if (correspondencia.corRemitente.toLowerCase().contains(busqueda)) correspondenciasFiltrado.add(correspondencia);
                        else if (correspondencia.cdeDetalles.toLowerCase().contains(busqueda)) correspondenciasFiltrado.add(correspondencia);
                        else if (correspondencia.cdeEstado.toLowerCase() == busqueda) correspondenciasFiltrado.add(correspondencia);
                        else if((ClsConversorFecha.convertirParaLecturaYHora(correspondencia.cdeFechaIni) as String).toLowerCase().contains(busqueda)) correspondenciasFiltrado.add(correspondencia);
                      });

                      return ListView.builder(
                        itemCount: correspondenciasFiltrado.length,
                        itemBuilder: (context, index) {
                          return ZoomIn(
                            duration: const Duration(milliseconds: 750),
                            delay: Duration(milliseconds: index * 25),
                            child: PerTarjetaCorrespondencia(
                              correspondencia: correspondenciasFiltrado.elementAt(index),
                            ),
                          );
                        },
                      );
                    }

                    return Center(child: CircularProgressIndicator());
                  }
                )
              )
            ],
          ),
        ),
      )
    );
  }
}