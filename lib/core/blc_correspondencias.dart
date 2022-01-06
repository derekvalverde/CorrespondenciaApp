import 'package:jaimito_app/core/modelos/cls_correspondencia.dart';
import 'package:jaimito_app/core/modelos/cls_division.dart';
import 'package:jaimito_app/core/modelos/cls_usuario.dart';
import 'package:jaimito_app/core/servicios/jaimito_api.dart';
import 'package:rxdart/rxdart.dart';

class BlcCorrespondencias {

  static final BlcCorrespondencias _singleton = BlcCorrespondencias._interno();

  BlcCorrespondencias._interno();

  factory BlcCorrespondencias() => _singleton;

  final _correspondenciasControlador = BehaviorSubject<List<ClsCorrespondencia>>();

  Stream<List<ClsCorrespondencia>> get correspondenciasStream => _correspondenciasControlador.stream;

  set correspondencias(List<ClsCorrespondencia> correspondencias) => _correspondenciasControlador.sink.add(correspondencias);

  List<ClsCorrespondencia> get correspondencias => _correspondenciasControlador.value;

  iniciarCorrespondencias() async {
    List<ClsCorrespondencia> respuesta = await ClsJaimitoApi().apiCorrespondenciaDetalleListar();
    correspondencias = respuesta;
  }

  void dispose() {
    _correspondenciasControlador?.close();
  }

}

BlcCorrespondencias blcCorrespondencias = BlcCorrespondencias();