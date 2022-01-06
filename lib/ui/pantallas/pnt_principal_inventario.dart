import 'package:flutter/material.dart';
import 'package:jaimito_app/core/blc_emplazamientos.dart';
import 'package:jaimito_app/core/blc_sesion_usuario.dart';
import 'package:jaimito_app/core/modelos/cls_emplazamiento.dart';
import 'package:jaimito_app/core/servicios/inventario_api.dart';
import 'package:jaimito_app/ui/pantallas/pnt_resultado_activo.dart';
import 'package:jaimito_app/ui/utils/show_loading.dart';
import 'package:jaimito_app/ui/widgets/per_tarjeta_inventario.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:toast/toast.dart';

class PntPrincipalInventario extends StatefulWidget {

  @override
  _PntPrincipalInventarioState createState() => _PntPrincipalInventarioState();
}

class _PntPrincipalInventarioState extends State<PntPrincipalInventario> {
  
  BlcSesionUsuario blcSesionUsuario = BlcSesionUsuario();
  BlcEmplazamientos blcEmplazamientos = BlcEmplazamientos();

  TextEditingController _buscadorControlador = TextEditingController();

  @override
  void initState() { 
    super.initState();
    blcEmplazamientos.obtenerEmplazamientos();
  }

  _escanearCodigoInventario() async {
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

          print('Resultado Escaneado: $resultadoEscaneo');

          // 100022
          final activoEscaneado = await InventarioApi().activoLeer(
            usuId: 1,
            actCodigo: resultadoEscaneo
          );

          Navigator.pop(context);
  
          Toast.show(
            "Activo escaneado correctamente", context,
            backgroundColor: Colors.green.shade800,
            textColor: Colors.white,
            gravity: Toast.BOTTOM,
            duration: Toast.LENGTH_LONG
          );

          Navigator.push(context, 
            MaterialPageRoute(builder: (_) => PntResultadoActivo(activo: activoEscaneado)));
        } catch (error) {
          print(error.toString());

          Toast.show(
            "Hubo un problema al escanear el activo", context,
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
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18
        ),
        child: StreamBuilder(
          stream: blcEmplazamientos.emplazamientosStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<ClsEmplazamiento> emplazamientos = snapshot.data;
              
              List<ClsEmplazamiento> emplazamientosFiltrado = [];
              String busqueda = _buscadorControlador.text ?? "";
              busqueda = busqueda.toLowerCase();
              
              emplazamientos.forEach((emplazamiento) {
                if (emplazamiento.empCodigo.toLowerCase().contains(busqueda) || emplazamiento.empDenominacion.toLowerCase().contains(busqueda)) {
                  emplazamientosFiltrado.add(emplazamiento);
                }
              });

              return Column(
                children: [
                  const SizedBox(height: 18),

                  TextField(
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

                  Expanded(
                    child: ListView.builder(
                      itemCount: emplazamientosFiltrado.length,
                      itemBuilder: (context, index) {
                        return PerTarjetaEmplazamiento(
                          emplazamiento: emplazamientosFiltrado[index],
                          onPressed: () {

                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: Text('¿Estás seguro de comenzar a escanear activos?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      }, 
                                      child: Text('Cancelar')
                                    ),

                                    TextButton(
                                      onPressed: () {
                                        
                                        Navigator.pop(context);
                                        _escanearCodigoInventario();

                                      },
                                      child: Text('Aceptar')
                                    )
                                  ],
                                );
                              }
                            );

                          },
                        );
                      }
                    ),
                  ),
                ],
              );
            }
              
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}