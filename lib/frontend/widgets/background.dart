import 'dart:math';
import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final boxDecoration = const BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [
        0.2,
        0.8
      ],
          colors: [
        Color.fromRGBO(248, 248, 248, 0.8),
        Color.fromRGBO(170, 173, 189, 1)
      ]));

  const Background({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: boxDecoration,
        ),
        Positioned(top: -300, left: 130, child: _Box()),
        Positioned(bottom: -300, right: 130, child: _Box()),
      ],
    );
  }
}

class _Box extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -pi / 5,
      child: Container(
        width: 360,
        height: 360,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(80),
            gradient: LinearGradient(colors: [
              Color.fromRGBO(248, 248, 248, 0.8),
              Color.fromRGBO(170, 173, 189, 1)
            ])),
      ),
    );
  }
}
