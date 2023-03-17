import 'package:calidad_del_servicio/services/services.dart';
import 'package:flutter/material.dart';

class InputDisenoRegistro extends StatefulWidget {
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final IconData? icon;
  IconData? suffixIcon;
  final TextInputType? keyboardType;
  bool obscureText;
  final String propiedad;
  final Map<String, String> formValues;
  // final Function(String?) validator;

  InputDisenoRegistro({
    Key? key,
    this.hintText,
    this.labelText,
    this.helperText,
    this.icon,
    this.suffixIcon,
    this.keyboardType,
    this.obscureText = false,
    required this.propiedad,
    required this.formValues,
  }) : super(key: key);

  @override
  State<InputDisenoRegistro> createState() => _InputDisenoRegistroState();
}

class _InputDisenoRegistroState extends State<InputDisenoRegistro> {
  @override
  Widget build(BuildContext context) {
    List<Map<String, Map<String, dynamic>>> result = [];
    ServicioPostgrest.selectUser().then((value) => result = value);
    return TextFormField(
        autofocus: false,
        initialValue: '',
        textCapitalization: TextCapitalization.words,
        keyboardType: widget.keyboardType,
        obscureText: widget.obscureText,
        onChanged: (value) => widget.formValues[widget.propiedad] = value,
        validator: (value) {
          for (final row in result) {
            if (row["user_data"]!["mail"] == value) {
              return 'Este correo ya se encuentra registrado';
            }

            if (row["user_data"]!["user_dni"] == value) {
              return 'Esta cédula ya está registrada';
            }
          }

          if (value == null) return 'este campo es requerido';
          return value.length < 3 ? 'Campo obligatorio' : null;
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        //autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
            hintText: widget.hintText,
            labelText: widget.labelText,
            helperText: widget.helperText,
            //prefixIcon: Icon(Icons.verified_user_outlined),
            suffixIcon: widget.suffixIcon == null
                ? null
                : IconButton(
                    icon: Icon(widget.suffixIcon),
                    onPressed: () {
                      if (widget.obscureText == true) {
                        widget.suffixIcon = Icons.visibility;
                        widget.obscureText = false;
                      } else {
                        widget.suffixIcon = Icons.visibility_off;
                        widget.obscureText = true;
                      }

                      setState(() {});
                    },
                  ),
            icon: widget.icon == null ? null : Icon(widget.icon),
            // border: OutlineInputBorder(
            //   borderRadius: BorderRadius.only(
            //       bottomLeft: Radius.circular(10),
            //       topRight: Radius.circular(10)),
            // )
            //counterText: '3 carácteres'),

            floatingLabelStyle: const TextStyle(color: Colors.indigo),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.indigo),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.indigo),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    topRight: Radius.circular(10)))));
  }
}
