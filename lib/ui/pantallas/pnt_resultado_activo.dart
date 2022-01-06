import 'package:flutter/material.dart';
import 'package:jaimito_app/core/modelos/cls_activo.dart';
import 'package:jaimito_app/core/servicios/inventario_api.dart';
import 'package:jaimito_app/ui/utils/colores.dart';
import 'package:jaimito_app/ui/utils/show_loading.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:toast/toast.dart';

class PntResultadoActivo extends StatefulWidget {

  ClsActivo activo;

  PntResultadoActivo({
    @required this.activo
  });

  @override
  _PntResultadoActivoState createState() => _PntResultadoActivoState();
}

class _PntResultadoActivoState extends State<PntResultadoActivo> {
  
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

          Navigator.pushReplacement(context, 
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
      appBar: AppBar(
        title: Text(
          'Resultado Escaneo'
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(
                top: 18
              ),
              decoration: BoxDecoration(
                color: inventarioColor,
                borderRadius: BorderRadius.circular(18)
              ),
              padding: const EdgeInsets.all(14),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(18)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: 'Codigo: ',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                        ),
                        children: [
                          TextSpan(
                            text: widget.activo.actCodigo,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: 20
                            )
                          )
                        ]
                      ),
                    ),

                    const SizedBox(height: 12),

                    RichText(
                      text: TextSpan(
                        text: 'Activo: ',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                        ),
                        children: [
                          TextSpan(
                            text: widget.activo.actDenominacion,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: 20
                            )
                          )
                        ]
                      ),
                    ),

                    const SizedBox(height: 12),

                    RichText(
                      text: TextSpan(
                        text: 'Emplazamiento: ',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                        ),
                        children: [
                          TextSpan(
                            text: widget.activo.empDenominacion,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: 20
                            )
                          )
                        ]
                      ),
                    ),

                    const SizedBox(height: 12),

                    RichText(
                      text: TextSpan(
                        text: 'Usuario: ',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                        ),
                        children: [
                          TextSpan(
                            text: widget.activo.usuNombre,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: 20
                            )
                          )
                        ]
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            Container(
              height: 80,
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {

                  _escanearCodigoInventario();

                },
                icon: Icon(
                  Icons.qr_code, 
                  color: Colors.white,
                  size: 32,
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Theme.of(context).primaryColor
                  ),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)
                    )
                  )
                ),
                label: Text(
                  'Escanear QR',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}