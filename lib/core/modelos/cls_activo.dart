import 'dart:convert';

ClsActivo clsActivoFromJson(String str) => ClsActivo.fromJson(json.decode(str));

String clsActivoToJson(ClsActivo data) => json.encode(data.toJson());

class ClsActivo {
    ClsActivo({
        this.actCodigo,
        this.actFechaCap,
        this.actDenominacion,
        this.usuNombre,
        this.empDenominacion,
        this.cenCodigo,
    });

    String actCodigo;
    DateTime actFechaCap;
    String actDenominacion;
    String usuNombre;
    String empDenominacion;
    int cenCodigo;

    factory ClsActivo.fromJson(Map<String, dynamic> json) => ClsActivo(
        actCodigo: json["actCodigo"],
        actFechaCap: DateTime.parse(json["actFechaCap"]),
        actDenominacion: json["actDenominacion"],
        usuNombre: json["usuNombre"],
        empDenominacion: json["empDenominacion"],
        cenCodigo: json["cenCodigo"],
    );

    Map<String, dynamic> toJson() => {
        "actCodigo": actCodigo,
        "actFechaCap": actFechaCap.toIso8601String(),
        "actDenominacion": actDenominacion,
        "usuNombre": usuNombre,
        "empDenominacion": empDenominacion,
        "cenCodigo": cenCodigo,
    };
}
