import 'package:calidad_del_servicio/frontend/widgets/widgets.dart';
import 'package:flutter/material.dart';

class InicioScreen extends StatelessWidget {
  const InicioScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Stack(
      children: [
        const Background(),
        Column(
          children: [
            Padding(
              padding:
                  EdgeInsets.only(top: height * 0.15, bottom: height * 0.1),
              child: Center(child: Image.asset('assets/logo_cti.png')),
            ),
            const SizedBox(
              height: 100,
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 60,
                  ),
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'inicio_sesion_screen');
                      },
                      // ignore: sort_child_properties_last
                      child: const Center(
                          child:
                              Text('Iniciar', style: TextStyle(fontSize: 18))),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(12, 31, 122, 1),
                          fixedSize: const Size.fromHeight(50),
                          side: const BorderSide(
                              color: Color.fromARGB(255, 189, 189, 189),
                              width: 1.5),
                          shape: const BeveledRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                          shadowColor: const Color.fromARGB(255, 0, 0, 0),
                          elevation: 10)),
                ),
                const SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'registro_screen');
                      },
                      // ignore: sort_child_properties_last
                      child: const Center(
                          child: Text(
                        'Registrarse',
                        style: TextStyle(fontSize: 18),
                      )),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(12, 31, 122, 1),
                          fixedSize: const Size.fromHeight(50),
                          side: const BorderSide(
                              color: Color.fromARGB(255, 189, 189, 189),
                              width: 1.5),
                          shape: const BeveledRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                          shadowColor: const Color.fromARGB(255, 0, 0, 0),
                          elevation: 10)),
                )
              ],
            ),
          ],
        )
      ],
    ));
  }
}
