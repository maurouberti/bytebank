import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TransacaoAuthDialog extends StatefulWidget {
  final Function(String) onConfirm;

  const TransacaoAuthDialog({@required this.onConfirm});

  @override
  _TransacaoAuthDialogState createState() => _TransacaoAuthDialogState();
}

class _TransacaoAuthDialogState extends State<TransacaoAuthDialog> {
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Autenticação'),
      content: TextField(
        controller: _passwordController,
        obscureText: true,
        maxLength: 4,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
        ),
        style: TextStyle(fontSize: 64, letterSpacing: 24),
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancelar'),
        ),
        FlatButton(
          onPressed: () {
            widget.onConfirm(_passwordController.text);
            Navigator.pop(context);
          },
          child: Text('Confirmar'),
        ),
      ],
    );
  }
}
