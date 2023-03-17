import 'package:flutter/material.dart';

class SurveyModel with ChangeNotifier {
  int _itemMarcado = 0;
  String _response = '';
  String _labelCalificacion = 'Elegir calificación';

  int get itemMarcado => _itemMarcado;

  set itemMarcado(int value) {
    _itemMarcado = value;
    notifyListeners();
  }

  String get response => _response;

  set response(String value) {
    _response = value;
    notifyListeners();
  }

  String get labelCalificacion => _labelCalificacion;

  set labelCalificacion(String value) {
    _labelCalificacion = value;
    notifyListeners();
  }
}
