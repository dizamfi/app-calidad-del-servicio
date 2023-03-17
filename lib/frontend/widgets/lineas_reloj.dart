import 'package:flutter/material.dart';
import 'dart:math';
// ignore: depend_on_referenced_packages
import 'package:vector_math/vector_math_64.dart' as vector;

class LineasReloj extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Dibujar las lineas
    final paint = Paint();

    for (int i = 0; i < 60; i++) {
      double minuto = (360 / 60) * i;
      paint.color = (i % 5 == 0) ? Colors.blueGrey : Colors.white;
      paint.strokeWidth = (i % 5 == 0) ? 4 : 1;
      int distanciaLinea = (i % 5 == 0) ? 6 : 10;

      double x1 = (size.width / 2) *
          ((size.width / 3) + distanciaLinea) *
          cos(vector.radians(minuto));

      double y1 = (size.height / 2) *
          ((size.width / 3) + distanciaLinea) *
          sin(vector.radians(minuto));

      final p1 = Offset(x1, y1);

      double x2 = (size.width / 2) +
          ((size.width / 3) + 10) * cos(vector.radians(minuto));

      double y2 = (size.height / 2) +
          ((size.width / 3) + 10) * sin(vector.radians(minuto));
      final p2 = Offset(x2, y2);

      canvas.drawLine(p1, p2, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
