import 'dart:math';

import 'package:flutter/material.dart';

import '../providers/cuenta_regresiva_provider.dart';

class RadialProgress extends StatefulWidget {
  final double porcentaje;
  final Color colorPrimario;
  final Color colorSecundario;
  final Widget? child;

  const RadialProgress(
      {required this.porcentaje,
      this.colorPrimario = Colors.blue,
      this.colorSecundario = Colors.grey,
      this.child});

  @override
  State<RadialProgress> createState() => _RadialProgressState();
}

class _RadialProgressState extends State<RadialProgress>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late double porcentajeAnterior;

  @override
  void initState() {
    porcentajeAnterior = widget.porcentaje;
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.forward(from: 0.0);

    final diferenciaAnimar = widget.porcentaje - porcentajeAnterior;
    porcentajeAnterior = widget.porcentaje;

    return AnimatedBuilder(
      animation: controller,
      // child: child,
      builder: (BuildContext context, Widget? child) {
        return Container(
            padding: EdgeInsets.all(10),
            width: double.infinity,
            height: 250,
            child: CustomPaint(
              painter: _MiRadialProgress(
                  (widget.porcentaje - diferenciaAnimar) +
                      (diferenciaAnimar * controller.value),
                  widget.colorPrimario,
                  widget.colorSecundario),
              child: widget.child,
            ));
      },
    );
  }
}

class _MiRadialProgress extends CustomPainter {
  // ignore: prefer_typing_uninitialized_variables
  final porcentaje;
  final Color colorPrimario;
  final Color colorSecundario;

  _MiRadialProgress(this.porcentaje, this.colorPrimario, this.colorSecundario);
  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Rect.fromCircle(center: Offset(0, 0), radius: 180);

    final Gradient gradiente = LinearGradient(
        colors: <Color>[Color(0xffc012FF), Color(0xff6005E68), colorPrimario]);
    // Circulo completado
    final paint = Paint()
      ..strokeWidth = 4
      ..color = Colors.transparent
      ..style = PaintingStyle.stroke;

    final Offset center = Offset(size.width * 0.5, size.height * 0.5);
    final double radio = min(size.width * 0.5, size.height * 0.5);
    canvas.drawCircle(center, radio, paint);

    // Arco
    final paintArco = Paint()
      ..strokeWidth = 8
      // ..color = colorPrimario
      ..shader = gradiente.createShader(rect)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    // Parte que se deberá ir llenando
    double arcAngle = 2 *
        pi *
        (porcentaje /
            (CuentaRegresivaProvider.time +
                CuentaRegresivaProvider.aumtentoTime));

    canvas.drawArc(Rect.fromCircle(center: center, radius: radio), -pi / 2,
        arcAngle, false, paintArco);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
