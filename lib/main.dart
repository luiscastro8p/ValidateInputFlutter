import 'package:flutter/material.dart';

void main() {
  runApp(const FlutterApp());
}

class FlutterApp extends StatelessWidget {
  const FlutterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: TextContrasena(),
      ),
    );
  }
}

class TextContrasena extends StatefulWidget {
  const TextContrasena({Key? key}) : super(key: key);

  @override
  State<TextContrasena> createState() => _TextContrasenaState();
}

class _TextContrasenaState extends State<TextContrasena> {
  bool _estaBien = false;

  String _general = "";
  String _sinespacios = "";
  String _caracteres = "";
  String _unnumero = "";
  String _unmayuscula = "";
  String _especiales = "";

  late final TextEditingController controlador;

  @override
  void initState() {
    controlador = TextEditingController();
    controlador.addListener(escuchador);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: 'Texto',
              hintText: "Introduce una contraseña valida",
              icon: _estaBien ? null : Icon(Icons.error),
            ),
            controller: controlador,
          ),
          Text(_general),
          Text(_sinespacios),
          Text(_caracteres),
          Text(_unnumero),
          Text(_unmayuscula),
          Text(_especiales),
        ],
      ),
    );
  }

  void escuchador() {
    setState(() {
      try {
        final general = RegExp(
            r'^(?=(?:.*\d){1})(?=(?:.*[A-Z]){1})(?=(?:.*[a-z]){1})(?=(?:.*[&$"%]){1})\S{0,5}$');
        _general = general.hasMatch(controlador.text)
            ? ""
            : "El text por lo menos debe de tener 5 caracteres, una mayuscula, ningun espacio" +
                'un numero y uno de los siguientes caracteres &%"';

        final regsinespacios = RegExp(r"\s+\b|\b\s");
        _sinespacios =
            !regsinespacios.hasMatch(controlador.text) ? "" : "Sin espacios";

        _caracteres =
            controlador.text.length < 5 ? "" : "Por lo menos 5 caracteres";

        final regnum = RegExp(r"[^\w\d]*([0-9])");
        _unnumero =
            regnum.hasMatch(controlador.text) ? "" : "Por lo menos un numero";

        final regmayuscula = RegExp(r"[^\w\d]*([A-Z])");
        _unmayuscula = regmayuscula.hasMatch(controlador.text)
            ? ""
            : "Por lo menos ua letra mayuscula";

        final regespeciales = RegExp(r"[&%'#]");
        _especiales = regespeciales.hasMatch(controlador.text)
            ? ""
            : "Por lo menos un caracter especial %&|<>#";

        _estaBien = true;
      } catch (e) {
        _estaBien = false;
      }
    });
  }
}

class ContrasenaError implements Exception {}
