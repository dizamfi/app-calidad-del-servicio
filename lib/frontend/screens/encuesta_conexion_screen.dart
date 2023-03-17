import 'package:calidad_del_servicio/frontend/providers/survey_model_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class EncuestaConexionScreen extends StatelessWidget {
  const EncuestaConexionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double textRating = 0;
    // String label = Provider.of<SurveyModel>(context).labelCalificacion;
    return ChangeNotifierProvider<SurveyModel>(
      create: (context) => SurveyModel(),
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '¿Cómo calificarías la experiencia de conexión?',
              style: TextStyle(fontSize: 30, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 25,
            ),
            Consumer<SurveyModel>(
              builder: (context, value, child) {
                return Text(
                  value.labelCalificacion,
                  style: TextStyle(fontSize: 20, color: Colors.black),
                  textAlign: TextAlign.center,
                );
              },
            ),
            const SizedBox(
              height: 25,
            ),
            Consumer<SurveyModel>(
              builder: (context, value, child) {
                return RatingBar.builder(
                  initialRating: 0,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: false, // Se pinta una estrella completa
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    switch (rating.toInt()) {
                      case 1:
                        value.labelCalificacion = 'Malo';
                        break;

                      case 2:
                        value.labelCalificacion = 'Puede mejorar';
                        break;
                      case 3:
                        value.labelCalificacion = 'Regular';
                        break;
                      case 4:
                        value.labelCalificacion = 'Bueno';
                        break;
                      case 5:
                        value.labelCalificacion = 'Muy bueno';
                        break;
                      default:
                    }
                    print(rating);
                    textRating = rating;
                  },
                );
              },
            ),
            const SizedBox(
              height: 35,
            ),
            ElevatedButton(
                child: const SizedBox(
                    width: 250,
                    child: Center(
                        child: Text(
                      'Continuar',
                      style: TextStyle(fontSize: 20),
                    ))),
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(12, 31, 122, 0.9),
                    fixedSize: const Size.fromHeight(45),
                    shape: const BeveledRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    shadowColor: const Color.fromARGB(255, 230, 196, 196),
                    elevation: 10),
                onPressed: (() {
                  print('valor: $textRating');
                  // Navigator.pushNamed(context, 'portal_cuativo_screen');
                  Navigator.pushReplacementNamed(
                      context, 'portal_cuativo_screen');
                }))
          ],
        ),
      ),
    );
  }
}
