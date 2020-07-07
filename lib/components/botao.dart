import 'package:flutter/material.dart';

class Botao extends StatelessWidget {

  final String textoBotao;
  final Function onPressed;

  const Botao({Key key, this.textoBotao, this.onPressed}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RaisedButton(
          child: Text(textoBotao),
          onPressed: onPressed,
      )
    );
  }
}
