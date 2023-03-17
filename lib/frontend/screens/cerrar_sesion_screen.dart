import 'package:flutter/material.dart';

class CerrarSesionScreen extends StatelessWidget {
  const CerrarSesionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor:
            Theme.of(context).scaffoldBackgroundColor.withOpacity(0.96),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                right: MediaQuery.of(context).size.width * 0.1,
                top: 20,
                child: IconButton(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.cancel_outlined,
                    color: Color.fromRGBO(12, 31, 122, 0.9),
                    size: 55,
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.25,
                width: MediaQuery.of(context).size.width * 0.7,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.info_outline_rounded,
                      color: Color.fromRGBO(12, 31, 122, 0.9),
                      size: 35,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Cerrar sesión...',
                      style: TextStyle(
                          color: Color.fromRGBO(12, 31, 122, 0.9),
                          fontSize: 25),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      '¿Estás seguro que deseas cerrar sesión y perder la conexión a Internet?',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              Positioned(
                width: MediaQuery.of(context).size.width * 0.8,
                bottom: 80,
                child: ElevatedButton(
                  onPressed: () => Navigator.pushReplacementNamed(
                      context, 'inicio_sesion_screen'),
                  child: const SizedBox(
                      width: double.infinity,
                      child: Center(
                          child: Text(
                        'Cerrar sesión',
                        style: TextStyle(fontSize: 20),
                      ))),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(12, 31, 122, 0.9),
                      fixedSize: const Size.fromHeight(45),
                      shape: const BeveledRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      shadowColor: const Color.fromARGB(255, 230, 196, 196),
                      elevation: 10),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
