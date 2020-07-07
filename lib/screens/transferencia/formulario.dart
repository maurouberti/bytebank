import 'package:bytebank/components/editor.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:flutter/material.dart';

const _tituloAppBar = 'Nova transferência';

const _rotuloCampoNumeroConta = 'Número da conta';
const _dicaCampoNumeroConta = '0000';

const _rotuloCampoValor = 'Valor';
const _dicaCampoValor = '0.00';

const _textoBotaoConfirmar = 'Confirmar';

class FormularioTransferencia extends StatefulWidget {
  final TextEditingController _controladorNumeroConta = TextEditingController();
  final TextEditingController _controladorValor = TextEditingController();

  void _criaTranferencia(BuildContext context) {
    int numeroConta = int.tryParse(_controladorNumeroConta.text);
    double valor = double.tryParse(_controladorValor.text);
    Transferencia transferenciaCriada = Transferencia(valor, numeroConta);
    if (numeroConta != null && valor != null) {
      Navigator.pop(context, transferenciaCriada);
    }
  }

  @override
  State<StatefulWidget> createState() {
    return FormularioTransferenciaState();
  }
}

class FormularioTransferenciaState extends State<FormularioTransferencia> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_tituloAppBar)),
      body: ListView(
        children: <Widget>[
          Editor(widget._controladorNumeroConta,
              rotulo: _rotuloCampoNumeroConta, dica: _dicaCampoNumeroConta),
          Editor(widget._controladorValor,
              rotulo: _rotuloCampoValor, dica: _dicaCampoValor, icone: Icons.monetization_on),
          RaisedButton(
              child: Text(_textoBotaoConfirmar),
              onPressed: () => widget._criaTranferencia(context))
        ],
      ),
    );
  }
}
