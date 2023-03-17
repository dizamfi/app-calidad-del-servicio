import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// class BackgroundContador extends StatelessWidget {
//   final Widget? child;
//   const BackgroundContador({super.key, this.child});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 70,
//       width: double.infinity,

//       // color: const Color(0xff615AAB),
//       child: CustomPaint(
//         painter: _BackgroundContadorPainter(),
//         child: child,
//       ),
//     );
//   }
// }

// class _BackgroundContadorPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final Gradient gradiente = const RadialGradient(colors: <Color>[
//       Color.fromARGB(32, 12, 56, 85),
//       Color.fromARGB(255, 30, 73, 73),
//       Color.fromARGB(33, 23, 75, 110),
//     ], stops: [
//       0.2,
//       0.5,
//       0.2
//     ], tileMode: TileMode.clamp, center: Alignment.bottomRight, radius: 2);

//     final Rect rect =
//         Rect.fromCircle(center: const Offset(8, 3.8), radius: 180);

//     final lapiz = Paint();

//     // Propiedades
//     lapiz.color = Color.fromARGB(255, 30, 73, 73);
//     lapiz.style = PaintingStyle.fill; //.fill  //.stroke
//     lapiz.strokeWidth = 5.0;
//     lapiz.shader = gradiente.createShader(rect);

//     final path = Path();

//     // Dibujar con el path y el lapiz

//     // path.lineTo(0, size.height * 0.5);
//     // path.lineTo(size.width * 0.1, size.height * 0.62);
//     // path.lineTo(size.width - (size.width * 0.1), size.height * 0.62);
//     // path.lineTo(size.width, size.height * 0.5);
//     // path.lineTo(size.width, 0);

//     path.lineTo(0, size.height - (size.height * 0.2));
//     path.lineTo(size.width * 0.1, size.height);
//     path.lineTo(size.width - (size.width * 0.1), size.height);
//     path.lineTo(size.width, size.height - (size.height * 0.2));
//     path.lineTo(size.width, -0);

//     //path.lineTo(0, size.height);
//     // path.lineTo(0, size.height);

//     // path.lineTo(0, size.height * 0.2);
//     // path.lineTo(0.2, size.height * 0.25);
//     // path.lineTo(size.width - 0.2, size.height * 0.25);
//     // path.lineTo(size.width, size.height * 0.2);
//     // path.lineTo(0, size.height);

//     canvas.drawPath(path, lapiz);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     // TODO: implement shouldRepaint
//     return true;
//     throw UnimplementedError();
//   }
// }

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

          // Text(
          //   titulo,
          //   style: TextStyle(
          //       fontSize: 25, color: colorBlanco, fontWeight: FontWeight.bold),
          // ),
          // FaIcon(
          //   icon,
          //   size: 130,
          //   color: Colors.white.withOpacity(0.2),
          // ),
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
