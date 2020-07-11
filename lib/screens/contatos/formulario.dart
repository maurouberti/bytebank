import 'package:bytebank/components/botao.dart';
import 'package:bytebank/components/editor.dart';
import 'package:bytebank/database/dao/contato_dao.dart';
import 'package:bytebank/models/contato.dart';
import 'package:bytebank/widgets/app_dependencies.dart';
import 'package:flutter/material.dart';

const _tituloAppBar = 'Novo contato';

const _rotuloCampoNumeroConta = 'Número da conta';
const _dicaCampoNumeroConta = '0000';

const _rotuloCampoValor = 'Nome';
const _dicaCampoValor = '';

const _textoBotaoConfirmar = 'Confirmar';

class FormularioContato extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FormularioContatoState();
  }
}

class FormularioContatoState extends State<FormularioContato> {
  final TextEditingController _controladorNumeroConta = TextEditingController();
  final TextEditingController _controladorNome = TextEditingController();

  void _criaContato(AppDependencies dependencies, BuildContext context) {
    int numeroConta = int.tryParse(_controladorNumeroConta.text);
    String nome = _controladorNome.text;
    Contato contatoCriado = Contato(0, nome, numeroConta);
    if (numeroConta != null && nome != null) {
      _save(dependencies.contatoDao, contatoCriado, context);
    }
  }

  void _save(ContatoDao contatoDao, Contato contatoCriado,
      BuildContext context) async {
    await contatoDao.save(contatoCriado);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final dependencies = AppDependencies.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(_tituloAppBar)),
      body: ListView(
        children: <Widget>[
          Editor(_controladorNome,
              rotulo: _rotuloCampoValor, dica: _dicaCampoValor),
          Editor(_controladorNumeroConta,
              rotulo: _rotuloCampoNumeroConta,
              dica: _dicaCampoNumeroConta,
              tipo: TextInputType.number),
          Botao(
            textoBotao: _textoBotaoConfirmar,
            onPressed: () => _criaContato(dependencies, context),
          ),
        ],
      ),
    );
  }
}
