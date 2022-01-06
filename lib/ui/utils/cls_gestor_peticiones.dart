import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jaimito_app/core/blc_sesion_usuario.dart';

class ClsGestorPeticiones {

  final _httpClient = new http.Client();

  BlcSesionUsuario _blcSesionUsuario = BlcSesionUsuario();

  Future<dynamic> postSinToken(String url, {headers, body}) {
    try {
      String token = '';

      return _httpClient
          .post(Uri.parse(url), body: body, headers: getHeaders(token))
          .then((http.Response respuesta) {
            final codigoRespuesta = respuesta.statusCode;

            if (codigoRespuesta < 200 || codigoRespuesta >= 400) {
              throw new Exception(respuesta.body);
            }

            return json.decode(respuesta.body);
          });

    } finally {

    }
  }

  Future<dynamic> post(String url, {headers, body}) async {
    try {

      String token = _blcSesionUsuario.usuario.token ?? '';

      print(url);

      return _httpClient
          .post(Uri.parse(url), body: body, headers: getHeaders(token))
          .then((http.Response respuesta) {
            final codigoRespuesta = respuesta.statusCode;

            if (codigoRespuesta < 200 || codigoRespuesta >= 400) {
              throw new Exception(respuesta.body);
            }

            return json.decode(respuesta.body);
          });

    } finally {

    }
  }

  getHeaders(String token) {
    Map<String, String> headers = Map();
    headers["Content-Type"] = 'application/json; charset=utf-8';
    if (token.length > 0) headers['Authorization'] = "Bearer " + token;
    return headers;
  }
}