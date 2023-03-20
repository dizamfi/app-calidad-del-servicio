import 'package:calidad_del_servicio/frontend/providers/cuenta_regresiva_provider.dart';
import 'package:calidad_del_servicio/frontend/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../widgets/widgets.dart';

// void main() => runApp(const PortalCautivoScreens());

class PortalCautivoScreens extends StatefulWidget {
  static String nombre_user = '';
  const PortalCautivoScreens({super.key});

  @override
  State<PortalCautivoScreens> createState() => _PortalCautivoScreensState();
}

class _PortalCautivoScreensState extends State<PortalCautivoScreens> {
  @override
  Widget build(BuildContext context) {
    final cuentaRegresivaProvider =
        Provider.of<CuentaRegresivaProvider>(context);

    return WillPopScope(
        onWillPop: () async {
          //alertCerrarSesion(context);
          Navigator.push(
              context,
              PageRouteBuilder(
                opaque: false,
                pageBuilder: (context, animation, secondaryAnimation) {
                  return const CerrarSesionScreen();
                },
              ));
          return true;
        },
        child: Scaffold(
          body: SafeArea(
            child: Stack(alignment: Alignment.center, children: [
              const BackgroundContador(
                titulo: 'Usuario 1',
                subtitulo: 'Tu tiempo de navegación es: ',
                icon: FontAwesomeIcons.wifi,
              ),
              const Positioned(
                  top: 270,
                  child: _CardReloj(
                    height: 250,
                  )),
              const Positioned(
                top: 35,
                left: 20,
                child: Text(
                  'Bienvenido...',
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 460,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Dirección IP: ',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          cuentaRegresivaProvider.ip,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Dirección MAC: ',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          cuentaRegresivaProvider.mac,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ]),
            // floatingActionButton: FloatingActionButton(
            //     onPressed: () {
            //       cuentaRegresivaProvider.timer();
            //     },
            //     child: Icon(cuentaRegresivaProvider.isRunning
            //         ? Icons.pause
            //         : Icons.play_arrow)),
          ),
        ));
  }
}

class _CardReloj extends StatelessWidget {
  final double height;

  const _CardReloj({
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    final cuentaRegresivaProvider =
        Provider.of<CuentaRegresivaProvider>(context);

    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.9,
      height: height,
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          boxShadow: const [
            BoxShadow(
              color: Colors.black45,
              blurRadius: 20,
            )
          ]),
      child: Contador(cuentaRegresivaProvider: cuentaRegresivaProvider),
    );
  }
}

void alertCerrarSesion(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return IntrinsicWidth(
        stepHeight: MediaQuery.of(context).size.height,
        stepWidth: MediaQuery.of(context).size.width,
        child: AlertDialog(
          elevation: 5,
          title: const Text('Cerrando Sesión...'),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text(
                '¿Estás seguro que deseas cerrar sesión y perder la conexión a Internet?',
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            TextButton(
              // onPressed: () {

              // },
              onPressed: () => Navigator.pushReplacementNamed(
                  context, 'inicio_sesion_screen'),
              child: const Text(
                'Cerrar sesión',
                style: TextStyle(
                    color: Color.fromRGBO(12, 31, 122, 0.9), fontSize: 15),
              ),
            ),
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.cancel,
                color: Color.fromRGBO(12, 31, 122, 0.9),
              ),
            )
          ],
        ),
      );
    },
  );
}
