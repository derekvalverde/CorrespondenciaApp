import 'dart:convert';

import 'package:jaimito_app/core/blc_sesion_usuario.dart';
import 'package:jaimito_app/core/modelos/cls_activo.dart';
import 'package:jaimito_app/core/modelos/cls_emplazamiento.dart';
import 'package:jaimito_app/ui/utils/cls_gestor_peticiones.dart';

class InventarioApi {

  ClsGestorPeticiones _clsGestorPeticiones = ClsGestorPeticiones();
  BlcSesionUsuario _blcSesionUsuario = BlcSesionUsuario();

  static final _urlBase = "http://apisip.inti.com.bo:8088";

  static final _urlApiActivoLeer = "/ApiActivoLeer";
  static final _urlApiEmplazamientoListar = "/ApiEmplazamientoListar";

  Future<List<ClsEmplazamiento>> emplazamientoListar({int usuId}) {
    String urlPeticion = _urlBase + _urlApiEmplazamientoListar;
  
    return _clsGestorPeticiones.postSinToken(
      urlPeticion,
      body: json.encode({
        "usuId": 1
      })
    ).then((respuesta) {
      return clsEmplazamientoFromJson(respuesta);
    });
  }

  Future<ClsActivo> activoLeer({String actCodigo, int usuId}) {
    String urlPeticion = _urlBase + _urlApiActivoLeer;

    print('Url Peticion: $urlPeticion');
 
    return _clsGestorPeticiones.postSinToken(
      urlPeticion,
      body: json.encode({
        "actCodigo": actCodigo,
        "usuId": 1
      })
    ).then((respuesta) {
      return ClsActivo.fromJson(respuesta);
    });
  }
}
