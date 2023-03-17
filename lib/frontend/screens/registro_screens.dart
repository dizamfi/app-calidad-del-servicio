import 'package:calidad_del_servicio/frontend/widgets/widgets.dart';
import 'package:calidad_del_servicio/services/servicio_postgres.dart';
import 'package:flutter/material.dart';

class RegistroScreen extends StatelessWidget {
  const RegistroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();

    final Map<String, String> formValues = {
      'nombre': '',
      'apellido': '',
      'correo': '',
      'contraseña': '',
      'cedula': '',
      'telefono': ''
    };

    return Scaffold(
        appBar: AppBar(
          title: const Text('Registro'),
          backgroundColor: Color.fromRGBO(12, 31, 122, 0.9),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Form(
              key: myFormKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  InputDisenoRegistro(
                    labelText: 'Nombre',
                    hintText: 'Nombre',
                    icon: Icons.people,
                    keyboardType: TextInputType.name,
                    propiedad: 'nombre',
                    formValues: formValues,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  InputDisenoRegistro(
                    labelText: 'Apellido',
                    hintText: 'Apellido',
                    icon: Icons.people,
                    keyboardType: TextInputType.name,
                    propiedad: 'apellido',
                    formValues: formValues,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  InputDisenoRegistro(
                    labelText: 'Correo',
                    hintText: 'Correo',
                    icon: Icons.email_rounded,
                    keyboardType: TextInputType.emailAddress,
                    propiedad: 'correo',
                    formValues: formValues,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  InputDisenoRegistro(
                    labelText: 'Contraseña',
                    hintText: 'Contraseña',
                    icon: Icons.lock,
                    suffixIcon: Icons.visibility_off,
                    obscureText: true,
                    propiedad: 'contraseña',
                    formValues: formValues,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  InputDisenoRegistro(
                    labelText: 'Cédula',
                    hintText: 'Cédula',
                    icon: Icons.email_rounded,
                    keyboardType: TextInputType.number,
                    propiedad: 'cedula',
                    formValues: formValues,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  InputDisenoRegistro(
                    labelText: 'Teléfono',
                    hintText: 'Teléfono',
                    icon: Icons.phone,
                    keyboardType: TextInputType.phone,
                    propiedad: 'telefono',
                    formValues: formValues,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                      // ignore: sort_child_properties_last
                      child: const SizedBox(
                          width: double.infinity,
                          child: Center(
                              child: Text(
                            'Registrar',
                            style: TextStyle(fontSize: 15),
                          ))),
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromRGBO(12, 31, 122, 0.9),
                          fixedSize: const Size.fromHeight(45),
                          shape: const BeveledRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          shadowColor: const Color.fromARGB(255, 230, 196, 196),
                          elevation: 10),
                      onPressed: () {
                        // ServicioPostgrest.selectUserEmail();
                        // ServicioNotificacionPush.initPlatformState();
                        FocusScope.of(context).requestFocus(FocusNode());
                        if (!myFormKey.currentState!.validate()) {
                          return;
                        }

                        // var connection = PostgreSQLConnection(
                        //     "200.10.150.149", 5432, "calidad_red",
                        //     username: "postgres", password: "h8bmbfar");
                        // await connection.open().then((value) {
                        //   debugPrint("Database Connected!");
                        // });

                        // List<Map<String, Map<String, dynamic>>> result =
                        //     await connection.mappedResultsQuery(
                        //         "INSERT INTO user_data(usuarionombre,usuarioapellido,mail,telefono,user_dni,user_password) VALUES(@nombre, @apellido, @correo, @telf, @dni, @pass);",
                        //         substitutionValues: {
                        //       "nombre": formValues['nombre'],
                        //       "apellido": formValues['apellido'],
                        //       "correo": formValues['correo'],
                        //       "telf": formValues['telefono'],
                        //       "dni": formValues['cedula'],
                        //       "pass": formValues['contraseña'],
                        //     });

                        ServicioPostgrest.insertRegistro(formValues);

                        print(formValues);
                        Navigator.pop(context);
                      }),
                ],
              ),
            ),
          ),
        ));
  }
}
