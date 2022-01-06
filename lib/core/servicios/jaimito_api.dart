import 'dart:convert';

import 'package:jaimito_app/core/blc_sesion_usuario.dart';
import 'package:jaimito_app/core/modelos/cls_correspondencia.dart';
import 'package:jaimito_app/core/modelos/cls_correspondencia_detallle.dart';
import 'package:jaimito_app/core/modelos/cls_division.dart';
import 'package:jaimito_app/core/modelos/cls_division_informacion.dart';
import 'package:jaimito_app/core/modelos/cls_usuario.dart';
import 'package:jaimito_app/ui/utils/cls_gestor_peticiones.dart';
import 'package:jaimito_app/ui/utils/cls_notificaciones_push_proovedor.dart';

class ClsJaimitoApi {
  ClsGestorPeticiones _clsGestorPeticiones = ClsGestorPeticiones();
  BlcSesionUsuario _blcSesionUsuario = BlcSesionUsuario();

  static final _urlBase = "http://apisip.inti.com.bo:8088";

  static final _urlUsuarioLoginGeneral = "/ApiUsuarioLoginGeneral";
  static final _urlApiLectorCelular = "/ApiLectorCelular";
  static final _urlApiDivisionListarCelular = "/ApiDivisionListarCelular";
  static final _urlApiDivisionInformacionCelular =
      "/ApiDivisionInformacionCelular";
  static final _urlApiUsuarioMensajeRegistrarToken =
      "/ApiUsuarioMensajeRegistrarToken";

  static final _urlApiCorrespondenciaDetalleListar =
      "/ApiCorrespondenciaDetalleListar";
  static final _urlApiCorrespondenciaDetalleInformacionCelular =
      "/ApiCorrespondenciaDetalleInformacionCelular";

  //
  // Endpoint - /ApiUsuarioLoginClient
  //
  Future<ClsUsuario> autenticarUsuario(
      {String mUsuLogin, String mUsuPassword}) async {
    String urlPeticion = _urlBase + _urlUsuarioLoginGeneral;

    return _clsGestorPeticiones
        .postSinToken(urlPeticion,
            body: json.encode({
              "usuLogin": mUsuLogin,
              "usuPassword": mUsuPassword,
              "grpId": 10
            }))
        .then((respuesta) {
      print(respuesta);
      return ClsUsuario.fromJson(respuesta);
    });
  }

  Future<List<ClsDivision>> apiDivisionListarCelular() {
    String urlPeticion = _urlBase + _urlApiDivisionListarCelular;

    return _clsGestorPeticiones
        .post(urlPeticion,
            body: json.encode({
              "UsuCodigo": _blcSesionUsuario.usuario.usuCodigo,
            }))
        .then((respuesta) {
      return ClsDivision.desdeListaJson(respuesta).divisiones;
    });
  }

  Future<List<ClsCorrespondencia>> apiCorrespondenciaDetalleListar() {
    String urlPeticion = _urlBase + _urlApiCorrespondenciaDetalleListar;

    return _clsGestorPeticiones
        .post(urlPeticion,
            body: json.encode({
              "usucodigo": _blcSesionUsuario.usuario.usuCodigo,
            }))
        .then((respuesta) {
      return ClsCorrespondencia.desdeListaJson(respuesta).correspondencias;
    });
  }

  Future<List<ClsCorrespondenciaDetalle>>
      apiCorrespondenciaDetalleInformacionCelular({int divId}) {
    String urlPeticion =
        _urlBase + _urlApiCorrespondenciaDetalleInformacionCelular;

    return _clsGestorPeticiones
        .post(urlPeticion,
            body: json.encode({
              "CdeId": divId,
            }))
        .then((respuesta) {
      return ClsCorrespondenciaDetalle.desdeListaJson(respuesta)
          .correspondencias;
    });
  }

  Future<List<ClsDivisionInformacion>> apiDivisionInformacionCelular(
      {int divId}) {
    String urlPeticion = _urlBase + _urlApiDivisionInformacionCelular;

    return _clsGestorPeticiones
        .post(urlPeticion,
            body: json.encode({
              "DivId": divId,
            }))
        .then((respuesta) {
      print(respuesta);
      return ClsDivisionInformacion.desdeListaJson(respuesta).informaciones;
    });
  }

  Future<bool> apiLectorCelular(
      {int lectorTipo, String codigo, String archivero}) {
    String urlPeticion = _urlBase + _urlApiLectorCelular;

    return _clsGestorPeticiones
        .post(urlPeticion,
            body: json.encode({
              "LectorTipo": lectorTipo,
              "UsuCodigo": _blcSesionUsuario.usuario.usuCodigo,
              "Codigo": codigo,
              "Archivero": archivero,
            }))
        .then((respuesta) {
      print(respuesta);
      return respuesta["escaneado"];
    });
  }

  Future<void> registrarFCMToken() async {
    String fcmToken = await NotificacionesPushProveedor().fcmToken();

    String urlPeticion = _urlBase + _urlApiUsuarioMensajeRegistrarToken;

    print("UsuID: ${_blcSesionUsuario.usuario.usuCodigo}");
    print("UsuToken: $fcmToken");
    return _clsGestorPeticiones
        .post(urlPeticion,
            body: json.encode({
              "UsuCodigo": _blcSesionUsuario.usuario.usuCodigo,
              "UsuToken": fcmToken
            }))
        .then((respuesta) {
      print(respuesta);
    });
  }
}
