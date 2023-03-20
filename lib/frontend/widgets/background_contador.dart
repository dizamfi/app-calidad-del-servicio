import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BackgroundContador extends StatelessWidget {
  final IconData icon;
  final String titulo;
  final String subtitulo;
  final Color? color1;
  final Color? color2;

  const BackgroundContador(
      {super.key,
      required this.icon,
      required this.titulo,
      required this.subtitulo,
      this.color1 = const Color(0xff526BF6),
      this.color2 = const Color(0xff67ACF2)});

  @override
  Widget build(BuildContext context) {
    final Color colorBlanco = Colors.white.withOpacity(0.7);
    return Stack(children: [
      _IconHeaderBackground(
        color1: color1!,
        color2: color2!,
      ),
      Positioned(
        top: -10,
        right: -80,
        child: FaIcon(
          icon,
          size: 160,
          color: Colors.white.withOpacity(0.2),
        ),
      ),
      Column(
        children: [
          const SizedBox(
            height: 100,
            width: double.infinity,
          ),
          Icon(
            Icons.person_pin,
            size: 60,
            color: Colors.white.withOpacity(0.8),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            titulo,
            style: TextStyle(
                fontSize: 25, color: colorBlanco, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 35,
          ),
          Text(
            subtitulo,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      )
    ]);
  }
}

class _IconHeaderBackground extends StatelessWidget {
  final Color color1;
  final Color color2;
  const _IconHeaderBackground({
    Key? key,
    required this.color1,
    required this.color2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 400,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(80)),
        gradient: LinearGradient(
            colors: [color1, color2],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter),
      ),
    );
  }
}
