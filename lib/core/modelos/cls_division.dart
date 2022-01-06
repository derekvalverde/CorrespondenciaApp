import 'dart:convert';

List<ClsDivision> clsDivisionFromJson(String str) => List<ClsDivision>.from(json.decode(str).map((x) => ClsDivision.fromJson(x)));

String clsDivisionToJson(List<ClsDivision> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ClsDivision {
    ClsDivision({
        this.divId,
        this.divCodigo,
        this.corRemitente,
        this.divDetalles,
        this.divFechaIni,
        this.divestado, // Pendiente, 
    });

    int divId;
    String divCodigo;
    String corRemitente;
    String divDetalles;
    DateTime divFechaIni;
    String divestado;

    List<ClsDivision> divisiones;

    ClsDivision.desdeListaJson(List<dynamic> data) {
      if (data == null) return;

      divisiones = [];
      for (var json in data) {
        divisiones.add(ClsDivision.fromJson(json));
      }
    }

    factory ClsDivision.fromJson(Map<String, dynamic> json) => ClsDivision(
        divId: json["divId"],
        divCodigo: json["divCodigo"],
        corRemitente: json["corRemitente"],
        divDetalles: json["divDetalles"],
        divFechaIni: DateTime.parse(json["divFechaIni"]),
        divestado: json["divestado"],
    );

    Map<String, dynamic> toJson() => {
        "divId": divId,
        "divCodigo": divCodigo,
        "corRemitente": corRemitente,
        "divDetalles": divDetalles,
        "divFechaIni": divFechaIni.toIso8601String(),
        "divestado": divestado,
    };
}
