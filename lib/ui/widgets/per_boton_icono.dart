import 'package:flutter/material.dart';
import 'package:jaimito_app/ui/utils/colores.dart';

class BotonIcono extends StatelessWidget {
  
  final Function mOnPressed;
  final Icon mIcono;

  BotonIcono({
    @required this.mOnPressed,
    @required this.mIcono
  });
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.mOnPressed,
      child: Container(
        padding: EdgeInsets.all(18),
        child: mIcono,
        decoration: BoxDecoration(
          color: primario,
          shape: BoxShape.circle
        ),
      ),
    );
  }
}