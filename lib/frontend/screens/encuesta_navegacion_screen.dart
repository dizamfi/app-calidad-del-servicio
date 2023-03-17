import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../providers/cuenta_regresiva_provider.dart';
import '../providers/survey_model_provider.dart';

class SurveyAnswer {
  final String text;
  final Function() onPressed;

  SurveyAnswer({required this.text, required this.onPressed});
}

class EncuestaNavegacionScreen extends StatelessWidget {
  final List<SurveyAnswer> items = [
    SurveyAnswer(
      text: 'Trabajo',
      onPressed: () => print('Trabajo'),
    ),
    SurveyAnswer(
      text: 'Estudios',
      onPressed: () => print('Estudios'),
    ),
    SurveyAnswer(
      text: 'Redes Sociales',
      onPressed: () => print('Redes Sociales'),
    ),
    SurveyAnswer(
      text: 'Juegos',
      onPressed: () => print('Juegos'),
    ),
    SurveyAnswer(
      text: 'Otros',
      onPressed: () => print('Otros'),
    ),
  ];

  static var response = '';

  EncuestaNavegacionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double textRating = 0;

    final cuentaRegresivaProvider =
        Provider.of<CuentaRegresivaProvider>(context, listen: false);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '¿Para qué utilizó el Internet?',
              style: TextStyle(fontSize: 24, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 25,
            ),
            ChangeNotifierProvider(
              create: (context) => SurveyModel(),
              child: Column(
                children: List.generate(items.length,
                    (i) => CustomSurvey(index: i, item: items[i])),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              '¿Cómo calificarías la experiencia con el uso del Internet?',
              style: TextStyle(fontSize: 24, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 25,
            ),
            RatingBar.builder(
              initialRating: 0,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                print(rating);
                textRating = rating;
              },
            ),
            SizedBox(
              height: 40,
            ),
            ElevatedButton(
                child: const SizedBox(
                    width: 250,
                    child: Center(
                        child: Text(
                      'Enviar',
                      style: TextStyle(fontSize: 20),
                    ))),
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(12, 31, 122, 0.9),
                    fixedSize: const Size.fromHeight(45),
                    shape: const BeveledRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    shadowColor: const Color.fromARGB(255, 230, 196, 196),
                    elevation: 10),
                onPressed: (() async {
                  debugPrint('Rating: $textRating');
                  debugPrint('Respuesta: $response');
                  CuentaRegresivaProvider.aumtentoTime = 1800;
                  await cuentaRegresivaProvider.stream.cancel();
                  // ignore: use_build_context_synchronously
                  Navigator.pushReplacementNamed(
                      context, 'portal_cuativo_screen');
                  cuentaRegresivaProvider.timer();
                }))
          ],
        ),
      ),
    );
  }
}

class CustomSurvey extends StatelessWidget {
  final int index;
  final SurveyAnswer item;
  const CustomSurvey({
    Key? key,
    required this.index,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final itemSeleccionado = Provider.of<SurveyModel>(context).itemMarcado;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: GestureDetector(
        onTap: () {
          Provider.of<SurveyModel>(context, listen: false).itemMarcado = index;
          Provider.of<SurveyModel>(context, listen: false).response = item.text;
          EncuestaNavegacionScreen.response =
              Provider.of<SurveyModel>(context, listen: false).response;
          item.onPressed();
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
                color: (itemSeleccionado == index)
                    ? const Color.fromRGBO(7, 7, 7, 0.898)
                    : const Color.fromRGBO(12, 31, 122, 0.9),
                width: 1),
            borderRadius: BorderRadius.circular(8),
            gradient: LinearGradient(
              colors: (itemSeleccionado == index)
                  ? [
                      const Color.fromARGB(255, 126, 156, 175),
                      const Color.fromARGB(255, 195, 196, 197),
                    ]
                  : [
                      const Color.fromARGB(255, 240, 243, 245),
                      const Color.fromARGB(255, 247, 243, 243),
                    ],
              stops: const [0.2, 0.9],
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.black26,
                  offset: const Offset(0.2, 0.5),
                  blurRadius: (itemSeleccionado == index) ? 10 : 3,
                  spreadRadius: 2)
            ],
          ),
          width: double.infinity,
          height: 60,
          child: Center(
              child: Text(
            item.text,
            style: const TextStyle(fontSize: 17),
          )),
        ),
      ),
    );
  }
}
