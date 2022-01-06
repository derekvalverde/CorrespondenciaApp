// To parse this JSON data, do
//
//     final clsCorrespondenciaDetalle = clsCorrespondenciaDetalleFromJson(jsonString);

import 'dart:convert';

List<ClsCorrespondenciaDetalle> clsCorrespondenciaDetalleFromJson(String str) => List<ClsCorrespondenciaDetalle>.from(json.decode(str).map((x) => ClsCorrespondenciaDetalle.fromJson(x)));

String clsCorrespondenciaDetalleToJson(List<ClsCorrespondenciaDetalle> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ClsCorrespondenciaDetalle {
    ClsCorrespondenciaDetalle({
        this.nombre,
        this.ubicacion,
        this.fecha,
    });

    String nombre;
    String ubicacion;
    DateTime fecha;

    List<ClsCorrespondenciaDetalle> correspondencias;

    ClsCorrespondenciaDetalle.desdeListaJson(List<dynamic> data) {
      if (data == null) return;

      correspondencias = [];
      for (var json in data) {
        correspondencias.add(ClsCorrespondenciaDetalle.fromJson(json));
      }
    }

    factory ClsCorrespondenciaDetalle.fromJson(Map<String, dynamic> json) => ClsCorrespondenciaDetalle(
        nombre: json["nombre"],
        ubicacion: json["ubicacion"],
        fecha: DateTime.parse(json["fecha"]),
    );

    Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "ubicacion": ubicacion,
        "fecha": fecha.toIso8601String(),
    };
}
