import 'package:jaimito_app/core/modelos/cls_usuario.dart';
import 'package:jaimito_app/core/servicios/jaimito_api.dart';
import 'package:rxdart/rxdart.dart';

class BlcSesionUsuario {

  static final BlcSesionUsuario _singleton = BlcSesionUsuario._interno();

  BlcSesionUsuario._interno();

  factory BlcSesionUsuario() => _singleton;

  final _usuarioControlador = BehaviorSubject<ClsUsuario>();

  ClsUsuario get usuario => _usuarioControlador.value;

  Future<void> iniciarSesion({
    String usuario,
    String contrasena
  }) async {
    final resUsuario = await ClsJaimitoApi().autenticarUsuario(mUsuLogin: usuario, mUsuPassword: contrasena);
    _usuarioControlador.sink.add(resUsuario);
    await ClsJaimitoApi().registrarFCMToken();
  }

  void dispose() {
    _usuarioControlador?.close();
  }
}