import 'package:jaimito_app/core/modelos/cls_emplazamiento.dart';
import 'package:jaimito_app/core/servicios/inventario_api.dart';
import 'package:rxdart/rxdart.dart';

class BlcEmplazamientos {

  final _emplazamientosControlador = BehaviorSubject<List<ClsEmplazamiento>>();

  Stream<List<ClsEmplazamiento>> get emplazamientosStream => _emplazamientosControlador.stream;

  set emplazamientos(List<ClsEmplazamiento> valor) => _emplazamientosControlador.sink.add(valor);

  List<ClsEmplazamiento> get emplazamientos => _emplazamientosControlador.value;

  Future<void> obtenerEmplazamientos() async {
    final respEmplazamientos = await InventarioApi().emplazamientoListar(usuId: 1);
    emplazamientos = respEmplazamientos;
  }

  void dispose() {
    _emplazamientosControlador?.close();
  }

}