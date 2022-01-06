import 'dart:convert';

ClsUsuario clsUsuarioFromJson(String str) => ClsUsuario.fromJson(json.decode(str));

String clsUsuarioToJson(ClsUsuario data) => json.encode(data.toJson());

class ClsUsuario {

    ClsUsuario({
        this.usuId,
        this.usuNombre,
        this.sgrTipoNombre,
        this.sgrId,
        this.usuCodigo,
        this.ageId,
        this.uscId,
        this.ageOficina,
        this.token,
    }) {
      this.contrasena = '';
    }

    int usuId;
    int ageId;
    String usuCodigo;
    String usuNombre;
    String sgrTipoNombre;
    int sgrId;
    int uscId;
    String ageOficina;
    String token;
    String contrasena;

    factory ClsUsuario.fromJson(Map<String, dynamic> json) => ClsUsuario(
        usuId: json["usuId"],
        usuNombre: json["usuNombre"],
        usuCodigo: json["usuCodigo"],
        sgrTipoNombre: json["sgrTipoNombre"],
        sgrId: json["sgrId"],
        ageId: json["ageId"],
        uscId: json["uscId"],
        ageOficina: json["ageOficina"],
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "usuId": usuId,
        "usuNombre": usuNombre,
        "sgrTipoNombre": sgrTipoNombre,
        "sgrId": sgrId,
        "usuCodigo" : usuCodigo,
        "ageId": ageId,
        "uscId": uscId,
        "ageOficina": ageOficina,
          "token": token,
    };
}
