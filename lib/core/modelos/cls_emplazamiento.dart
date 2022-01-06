import 'dart:convert';

List<ClsEmplazamiento> clsEmplazamientoFromJson(List<dynamic> data) => List<ClsEmplazamiento>.from(data.map((x) => ClsEmplazamiento.fromJson(x)));

String clsEmplazamientoToJson(List<ClsEmplazamiento> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ClsEmplazamiento {
    ClsEmplazamiento({
        this.empId,
        this.empCodigo,
        this.empDenominacion,
    });

    int empId;
    String empCodigo;
    String empDenominacion;

    factory ClsEmplazamiento.fromJson(Map<String, dynamic> json) => ClsEmplazamiento(
        empId: json["empId"],
        empCodigo: json["empCodigo"],
        empDenominacion: json["empDenominacion"],
    );

    Map<String, dynamic> toJson() => {
        "empId": empId,
        "empCodigo": empCodigo,
        "empDenominacion": empDenominacion,
    };
}
