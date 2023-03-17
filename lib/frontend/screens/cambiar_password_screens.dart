import 'package:flutter/material.dart';

import '../widgets/input_diseno_inicio.dart';

class CambiarPasswordScreen extends StatelessWidget {
  const CambiarPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: const Color.fromRGBO(
          12,
          31,
          122,
          0.9,
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        child: Column(
          children: [
            const Center(
              child: Icon(
                Icons.lock_outline,
                color: Color.fromRGBO(
                  12,
                  31,
                  122,
                  0.9,
                ),
                size: 55,
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Cambia tu contraseña',
              style: TextStyle(
                fontSize: 28,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'Ingresa tu cédula de indentidad para reestablecer tu contraseña',
              style: TextStyle(color: Colors.black87, fontSize: 15),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 50),
            InputDisenoInicio(
              labelText: 'Cédula de identidad',
              keyboardType: TextInputType.number,
              propiedad: 'cedula',
              formValues: {},
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(12, 31, 122, 0.9),
                    fixedSize: const Size.fromHeight(45),
                    shape: const BeveledRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    shadowColor: const Color.fromARGB(255, 230, 196, 196),
                    elevation: 10),
                onPressed: () {},
                child: const SizedBox(
                    width: double.infinity,
                    child: Center(
                        child: Text(
                      'Continuar',
                      style: TextStyle(fontSize: 20),
                    ))))
          ],
        ),
      ),
    );
  }
}
