import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart' as http;

class ServicioNotificacionPush {
  static FirebaseMessaging mensajeria = FirebaseMessaging.instance;
  static String? token;
  static StreamController<String> _messageStream =
      new StreamController.broadcast();
  static Stream<String> get messagesStream => _messageStream.stream;

  static Future _backgroundMessage(RemoteMessage mensaje) async {
    print('Background ${mensaje.messageId}');

    _messageStream.add(mensaje.data['string'] ?? 'No data');

    print(mensaje.data);
  }

  static Future _onMessage(RemoteMessage mensaje) async {
    print('onMessageHandler ${mensaje.messageId}');
    _messageStream.add(mensaje.data['string'] ?? 'No data');
  }

  static Future _onMessageOpenApp(RemoteMessage mensaje) async {
    print('onMessageOpenApp ${mensaje.messageId}');
    _messageStream.add(mensaje.data['string'] ?? 'No data');
  }

  static Future initizalizeApp() async {
    await Firebase.initializeApp();
    token = await FirebaseMessaging.instance.getToken();
    print('Token: $token');

    // Handlers
    FirebaseMessaging.onBackgroundMessage(_backgroundMessage);
    FirebaseMessaging.onMessage.listen(_onMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);
  }

  static closeStreams() {
    _messageStream.close();
  }

  static void enviarPeticion() {
    var url = Uri.parse('https://fcm.googleapis.com/fcm/send');
    var body = '''{
      "to":"$token",
      "data":{},
      "notification":{
  	      "title":"Título",
          "body":"Llenar la encuesta"
        }
    }''';

    http.post(url, body: body).then((response) {
      print('Respuesta de FCM: ${response.body}');
    });
  }
}
