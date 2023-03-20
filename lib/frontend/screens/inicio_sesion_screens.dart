import 'package:calidad_del_servicio/services/services.dart';
import 'package:flutter/material.dart';
import 'package:calidad_del_servicio/services/servicio_postgres.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../providers/cuenta_regresiva_provider.dart';
import '../widgets/widgets.dart';

class IncioSesionScreen extends StatelessWidget {
  // static String mensajePortal = 'Prueba';
  const IncioSesionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();
    // final Map<String, String> formValues = {
    //   'cedula': '',
    //   'contrasena': '',
    // };

    final model = Provider.of<CuentaRegresivaProvider>(context, listen: false);

    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        child: Form(
          key: myFormKey,
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.center,
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 100),
              Center(child: Image.asset('assets/cti_logo2.png')),
              const SizedBox(height: 30),
              const Text(
                'Bienvenido',
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Para empezar inicia sesión con tu cédula y contraseña',
                style: TextStyle(color: Colors.black87, fontSize: 15),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 50),
              InputDisenoInicio(
                labelText: 'Cédula',
                keyboardType: TextInputType.number,
                propiedad: 'cedula',
                formValues: model.formValues,
              ),
              const SizedBox(height: 15),
              InputDisenoInicio(
                labelText: 'Contraseña',
                keyboardType: TextInputType.visiblePassword,
                suffixIcon: Icons.visibility_off,
                obscureText: true,
                propiedad: 'contrasena',
                formValues: model.formValues,
              ),
              const SizedBox(
                height: 40,
              ),
              TextButton(
                // ignore: sort_child_properties_last
                child: const Text('¿Olvidaste tu contraseña?',
                    style: TextStyle(
                        color: Color.fromRGBO(
                          12,
                          31,
                          122,
                          0.9,
                        ),
                        fontSize: 17)),
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.resolveWith(
                        (state) => Colors.white)),
                onPressed: () {
                  Navigator.pushNamed(context, 'cambiar_password_screen');
                },
              ),
              const SizedBox(
                height: 12,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(12, 31, 122, 0.9),
                      fixedSize: const Size.fromHeight(45),
                      shape: const BeveledRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      shadowColor: const Color.fromARGB(255, 230, 196, 196),
                      elevation: 10),
                  onPressed: () async {
                    FocusScope.of(context).requestFocus(FocusNode());

                    List<Map<String, Map<String, dynamic>>> resultado = [];
                    await ServicioPostgrest.query_user_pass(model.formValues)
                        .then((value) => resultado = value);
                    print(model.formValues['cedula']);
                    print(model.formValues['contrasena']);

                    if (resultado.isEmpty) {
                      debugPrint("ERROR DE INGRESO DE DATOS");
                      print(resultado);
                      print(model.formValues['cedula']);
                      print(model.formValues['contrasena']);
                      // ignore: use_build_context_synchronously
                      alertDialog(context);
                    } else {
                      // // ignore: use_build_context_synchronously
                      // alertDialogConectar(context);
                      // ignore: use_build_context_synchronously
                      int estado = 0;
                      await ServicioPostgrest.verificarSesion().then(
                        (value) => estado = value,
                      );

                      if (estado == 0 || estado == -1) {
                        // ignore: use_build_context_synchronously
                        alertDialogConectar(context);
                      } else {
                        // ignore: use_build_context_synchronously
                        Navigator.pushReplacementNamed(
                            context, 'portal_cuativo_screen');
                      }
                    }
                  },
                  child: const SizedBox(
                      width: double.infinity,
                      child: Center(
                          child: Text(
                        'Iniciar sesión',
                        style: TextStyle(fontSize: 20),
                      )))),
            ],
          ),
        ),
      ),
    ));
  }
}

void alertDialog(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return AlertDialog(
        elevation: 5,
        title: const Text('CTI'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text(
              'La cédula o contraseña no coinciden en nuestros registros',
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            // onPressed: () {

            // },
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Aceptar',
              style: TextStyle(
                  color: Color.fromRGBO(12, 31, 122, 0.9), fontSize: 15),
            ),
          )
        ],
      );
    },
  );
}

void alertDialogConectar(BuildContext context) {
  final model = Provider.of<CuentaRegresivaProvider>(context, listen: false);
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return AlertDialog(
        elevation: 5,
        title: const Text('Proceso de Conexión'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        content: Column(
          children: [
            const Spacer(),
            Center(
                child: Image.asset(
              'assets/image.png',
              height: 250,
            )),
            // SizedBox(
            //   height: 40,
            // ),
            // const Center(
            //     child: Icon(
            //   Icons.wifi,
            //   size: 70,
            // )),
            const Spacer(),
            const Text(
              'De click en conectar y luego en continuar',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            const Spacer(),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80),
                child: WebViewWidget(
                    controller: WebViewController()
                      ..setJavaScriptMode(JavaScriptMode.unrestricted)
                      ..setBackgroundColor(const Color(0x00000000))
                      ..addJavaScriptChannel('Print',
                          onMessageReceived: ((mensaje) {
                        List<String> list = mensaje.message.split(", ");

                        if (model.ip == '1.1.1.1' &&
                            model.mac == '00:00:00:00') {
                          model.ip = list[0];

                          model.mac = list[1];
                        }

                        debugPrint(mensaje.message);
                      }))
                      ..setNavigationDelegate(
                        NavigationDelegate(
                          onProgress: (int progress) {
                            // Update loading bar.
                          },
                          onPageStarted: (String url) {},
                          onPageFinished: (String url) {},
                          onWebResourceError: (WebResourceError error) {},
                          // onNavigationRequest: (NavigationRequest request) {
                          //   if (request.url.startsWith('https://www.youtube.com/')) {
                          //     return NavigationDecision.prevent;
                          //   }
                          //   return NavigationDecision.navigate;
                          // },
                        ),
                      )
                      // ' http://192.168.1.1:2050/nodogsplash_auth/'
                      ..loadRequest(
                          Uri.parse('http://192.168.1.1:2050/splash.html?'))),
              ),
            ),
            const Spacer()
          ],
        ),
        actions: [
          TextButton(
            onPressed: () async {
              // Navigator.pushReolacedName(context, 'encuesta_conexion_screen'),
              Navigator.pushReplacementNamed(
                  context, 'encuesta_conexion_screen');

              Provider.of<CuentaRegresivaProvider>(context, listen: false)
                  .timer();

              ServicioPostgrest.queryInicioSesion(
                  model.mac, model.ip, model.formValues);

              // ignore: use_build_context_synchronously
            },
            child: const Text(
              'Continuar',
              style: TextStyle(
                  color: Color.fromRGBO(12, 31, 122, 0.9), fontSize: 15),
            ),
          )
        ],
      );
    },
  );
}
