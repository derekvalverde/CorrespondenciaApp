import 'package:flutter/material.dart';
import 'package:jaimito_app/ui/utils/colores.dart';

class PerBotonRedondeado extends StatelessWidget {
  
  final Function mOnPressed;
  final Widget child;

  PerBotonRedondeado({
    @required this.mOnPressed,
    @required this.child
  });
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: mOnPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        child: this.child,
        decoration: BoxDecoration(
          color: primario,
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              offset: Offset(2, 2),
              blurRadius: 3,
              spreadRadius: 3,
              color: Colors.black12
            )
          ]
        ),
      ),
    );
  }
}