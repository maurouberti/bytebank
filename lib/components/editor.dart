import 'package:flutter/material.dart';

class Editor extends StatelessWidget {
  final TextEditingController controlador;
  final String rotulo;
  final String dica;
  final IconData icone;
  final TextInputType tipo;

  const Editor(this.controlador, {Key key, this.rotulo, this.dica, this.icone, this.tipo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: controlador,
        style: TextStyle(fontSize: 24.0),
        decoration: InputDecoration(
          icon: icone == null ? null : Icon(icone),
          labelText: rotulo,
          hintText: dica,
        ),
        keyboardType: tipo == null ? null : tipo,
      ),
    );
  }
}
