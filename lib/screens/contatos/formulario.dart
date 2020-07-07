import 'package:bytebank/components/botao.dart';
import 'package:bytebank/components/editor.dart';
import 'package:bytebank/database/dao/contato_dao.dart';
import 'package:bytebank/models/contato.dart';
import 'package:flutter/material.dart';

const _tituloAppBar = 'Novo contato';

const _rotuloCampoNumeroConta = 'Número da conta';
const _dicaCampoNumeroConta = '0000';

const _rotuloCampoValor = 'Nome';
const _dicaCampoValor = '';

const _textoBotaoConfirmar = 'Confirmar';

class FormularioContato extends StatefulWidget {
  final TextEditingController _controladorNumeroConta = TextEditingController();
  final TextEditingController _controladorNome = TextEditingController();

  final ContatoDao _dao = ContatoDao();

  void _criaContato(BuildContext context) {
    int numeroConta = int.tryParse(_controladorNumeroConta.text);
    String nome = _controladorNome.text;
    Contato contatoCriado = Contato(0, nome, numeroConta);
    if (numeroConta != null && nome != null) {
      _dao.save(contatoCriado).then((id) => Navigator.pop(context));
    }
  }

  @override
  State<StatefulWidget> createState() {
    return FormularioContatoState();
  }
}

class FormularioContatoState extends State<FormularioContato> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_tituloAppBar)),
      body: ListView(
        children: <Widget>[
          Editor(widget._controladorNome,
              rotulo: _rotuloCampoValor,
              dica: _dicaCampoValor),
          Editor(widget._controladorNumeroConta,
              rotulo: _rotuloCampoNumeroConta,
              dica: _dicaCampoNumeroConta,
              tipo: TextInputType.number),
          Botao(
            textoBotao: _textoBotaoConfirmar, 
            onPressed: () => widget._criaContato(context),
          ),
        ],
      ),
    );
  }
}
