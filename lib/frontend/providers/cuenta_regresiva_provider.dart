import 'dart:async';

import 'package:flutter/material.dart';

class CuentaRegresivaProvider extends ChangeNotifier {
  static double tiempoRestante = 0.0;
  static int aumtentoTime = 0;
  static int time = 7200;

  Duration duracion = const Duration(seconds: 7200);
  //bool isRunning = false;
  String ip = '1.1.1.1';
  String mac = '00:00:00:00';
  late StreamSubscription<int> stream;
  final Map<String, String> formValues = {
    'cedula': '',
    'contrasena': '',
  };

  // bool _isReflecting = false;
  // late Timer time;

  void timer() {
    _iniciarTimer(duracion.inSeconds + aumtentoTime);
    notifyListeners();
    // if (!isRunning) {
    //   _iniciarTimer(duracion.inSeconds + aumtentoTime);

    // } else {}
    //isRunning = !isRunning;
  }

  void _iniciarTimer(int segundos) {
    stream = Stream<int>.periodic(
            const Duration(seconds: 1), (sec) => segundos - sec - 1)
        .take(segundos)
        .listen((tiempoRestante) {
      duracion = Duration(seconds: tiempoRestante);
      notifyListeners();
    });
  }

  String get tiempoRestanteString {
    final horas =
        ((duracion.inSeconds / 3600) % 3600).floor().toString().padLeft(2, '0');
    final minutos =
        ((duracion.inSeconds / 60) % 60).floor().toString().padLeft(2, '0');
    final segundos =
        (duracion.inSeconds % 60).floor().toString().padLeft(2, '0');
    return '$horas:$minutos:$segundos';
  }

  double get tiempoRestanteSecond {
    return time - tiempoLlevadoDouble;
  }

  double get tiempoLlevadoDouble {
    print((duracion.inSeconds).floor().toDouble());
    tiempoRestante =
        (time + aumtentoTime) - (duracion.inSeconds).floor().toDouble();
    print('Tiempo restante: $tiempoRestante');
    return (time + aumtentoTime) - (duracion.inSeconds).floor().toDouble();
  }

  double get timeOneSecond {
    return tiempoLlevadoDouble / tiempoLlevadoDouble;
  }
}
