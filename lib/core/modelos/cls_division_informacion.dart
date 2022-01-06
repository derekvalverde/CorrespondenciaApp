import 'dart:convert';

List<ClsDivisionInformacion> clsDivisionInformacionFromJson(String str) => List<ClsDivisionInformacion>.from(json.decode(str).map((x) => ClsDivisionInformacion.fromJson(x)));

String clsDivisionInformacionToJson(List<ClsDivisionInformacion> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ClsDivisionInformacion {
    ClsDivisionInformacion({
        this.nombre,
        this.ubicacion,
        this.fecha,
    });

    String nombre;
    String ubicacion;
    DateTime fecha;

    List<ClsDivisionInformacion> informaciones;

    ClsDivisionInformacion.desdeListaJson(List<dynamic> data) {
      if (data == null) return;

      informaciones = [];

      for (var json in data) {
        informaciones.add(ClsDivisionInformacion.fromJson(json));
      }
    }

    factory ClsDivisionInformacion.fromJson(Map<String, dynamic> json) => ClsDivisionInformacion(
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
