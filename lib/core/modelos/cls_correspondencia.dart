import 'dart:convert';

List<ClsCorrespondencia> clsCorrespondenciaFromJson(String str) => List<ClsCorrespondencia>.from(json.decode(str).map((x) => ClsCorrespondencia.fromJson(x)));

String clsCorrespondenciaToJson(List<ClsCorrespondencia> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ClsCorrespondencia {
    ClsCorrespondencia({
        this.cdeId,
        this.cdeCodigo,
        this.corRemitente,
        this.cdeDetalles,
        this.corCodigo,
        this.cdeFechaIni,
        this.cdeEstado,
        this.destinatario,
        this.usuActual,
        this.couActual,
    });

    int cdeId;
    String cdeCodigo;
    String corRemitente;
    String cdeDetalles;
    String corCodigo;
    DateTime cdeFechaIni;
    //
    // Tipos de estado
    // Pendiente - PE
    // Registrado - RG
    // Archivado - AR
    //
    String cdeEstado;
    String destinatario;
    String usuActual;
    String couActual;

    List<ClsCorrespondencia> correspondencias;

    ClsCorrespondencia.desdeListaJson(List<dynamic> data) {
      if (data == null) return;

      correspondencias = [];
      for (var json in data) {
        correspondencias.add(ClsCorrespondencia.fromJson(json));
      }
    }

    factory ClsCorrespondencia.fromJson(Map<String, dynamic> json) => ClsCorrespondencia(
        cdeId: json["cdeId"],
        cdeCodigo: json["cdeCodigo"],
        corRemitente: json["corRemitente"],
        cdeDetalles: json["cdeDetalles"],
        corCodigo: json["corCodigo"],
        cdeFechaIni: DateTime.parse(json["cdeFechaIni"]),
        cdeEstado: json["cdeEstado"],
        destinatario: json["destinatario"],
        usuActual: json["usuActual"],
        couActual: json["couActual"],
    );

    Map<String, dynamic> toJson() => {
        "cdeId": cdeId,
        "cdeCodigo": cdeCodigo,
        "corRemitente": corRemitente,
        "cdeDetalles": cdeDetalles,
        "corCodigo": corCodigo,
        "cdeFechaIni": cdeFechaIni.toIso8601String(),
        "cdeEstado": cdeEstado,
        "destinatario": destinatario,
        "usuActual": destinatario,
        "couActual": couActual
    };
}