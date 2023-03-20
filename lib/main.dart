import 'package:calidad_del_servicio/frontend/providers/cuenta_regresiva_provider.dart';
import 'package:calidad_del_servicio/frontend/screens/screens.dart';
import 'package:calidad_del_servicio/services/services.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ServicioNotificacionPush.initizalizeApp();
  ServicioPostgrest.inializatePostgres();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldMessengerState> messengerKey =
      new GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    ServicioNotificacionPush.messagesStream.listen((message) {
      navigatorKey.currentState
          ?.pushNamed('encuesta_navegacion_screen', arguments: message);

      final snackBar = SnackBar(content: Text(message));
      messengerKey.currentState?.showSnackBar(snackBar);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CuentaRegresivaProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // routerConfig: _router,
        initialRoute: 'inicio_screen',
        navigatorKey: navigatorKey,
        scaffoldMessengerKey: messengerKey,
        routes: {
          'inicio_screen': ((_) => const InicioScreen()),
          'registro_screen': ((_) => const RegistroScreen()),
          'inicio_sesion_screen': ((_) => const IncioSesionScreen()),
          'portal_cuativo_screen': ((_) => const PortalCautivoScreens()),
          'cambiar_password_screen': ((_) => const CambiarPasswordScreen()),
          'encuesta_conexion_screen': ((_) => const EncuestaConexionScreen()),
          'encuesta_navegacion_screen': ((_) => EncuestaNavegacionScreen()),
          'cerrar_sesion_screen': ((_) => const CerrarSesionScreen())
        },
      ),
    );
  }
}
