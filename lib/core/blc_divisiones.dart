import 'package:jaimito_app/core/modelos/cls_division.dart';
import 'package:jaimito_app/core/modelos/cls_usuario.dart';
import 'package:jaimito_app/core/servicios/jaimito_api.dart';
import 'package:rxdart/rxdart.dart';

class BlcDivisiones {

  static final BlcDivisiones _singleton = BlcDivisiones._interno();

  BlcDivisiones._interno();

  factory BlcDivisiones() => _singleton;

  final _divisionesControlador = BehaviorSubject<List<ClsDivision>>();

  Stream<List<ClsDivision>> get divisionesStream => _divisionesControlador.stream;

  set divisiones(List<ClsDivision> divisiones) => _divisionesControlador.sink.add(divisiones);

  List<ClsDivision> get divisiones => _divisionesControlador.value;

  iniciarDivisiones() async {
    List<ClsDivision> respuesta = await ClsJaimitoApi().apiDivisionListarCelular();
    divisiones = respuesta;
  }

  void dispose() {
    _divisionesControlador?.close();
  }

}

BlcDivisiones blcDivisiones = BlcDivisiones();