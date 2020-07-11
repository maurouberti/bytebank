import 'package:bytebank/components/botao.dart';
import 'package:bytebank/components/editor.dart';
import 'package:bytebank/components/response_dialog.dart';
import 'package:bytebank/components/transacao_auth_dialog.dart';
import 'package:bytebank/http/webclients/transacao_webclient.dart';
import 'package:bytebank/models/contato.dart';
import 'package:bytebank/models/transacao.dart';
import 'package:bytebank/widgets/app_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

const _tituloAppBar = 'Nova transação';

const _rotuloCampoValor = 'Valor da transação';
const _dicaCampoValor = '0.00';

const _textoBotaoConfirmar = 'Confirmar';

class FormularioTransacao extends StatefulWidget {
  final Contato contato;

  FormularioTransacao(this.contato);

  @override
  State<StatefulWidget> createState() {
    return FormularioTransacaoState();
  }
}

class FormularioTransacaoState extends State<FormularioTransacao> {
  final TextEditingController _controladorValor = TextEditingController();
  final String uuid = Uuid().v4();
  bool _enviando = false;

  @override
  Widget build(BuildContext context) {
    final dependencies = AppDependencies.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(_tituloAppBar)),
      body: ListView(
        children: <Widget>[
          Visibility(
            visible: _enviando,
            child: LinearProgressIndicator(),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              widget.contato.nome,
              style: TextStyle(
                fontSize: 24.0,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              widget.contato.numeroConta.toString(),
              style: TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Editor(_controladorValor,
              rotulo: _rotuloCampoValor,
              dica: _dicaCampoValor,
              tipo: TextInputType.number),
          Botao(
            textoBotao: _textoBotaoConfirmar,
            onPressed: () {
              final double valor = double.tryParse(_controladorValor.text);
              final transacaoCriada = Transacao(uuid, valor, widget.contato);
              showDialog(
                  context: context,
                  builder: (contextDialog) {
                    return TransacaoAuthDialog(
                      onConfirm: (String password) {
                        _salvar(dependencies.transacaoWebClient, transacaoCriada, password, context);
                      },
                    );
                  });
            },
          ),
        ],
      ),
    );
  }

  void _salvar(
    TransacaoWebClient webClient,
    Transacao transacaoCriada,
    String password,
    BuildContext context,
  ) async {
    setState(() => _enviando = true);

    final statusCode =
        await webClient.save(transacaoCriada, password).catchError((err) {
      _showErro(context, mensagem: err.message);
    }, test: (err) => err is MyHttpException).catchError((err) {
      _showErro(context, mensagem: 'Tempo excedido.');
    }, test: (err) => err is Exception).catchError((err) {
      _showErro(context);
    }, test: (err) => err is MyHttpException).whenComplete(() {
      setState(() => _enviando = false);
    });

    if (statusCode == 201) {
      await showDialog(
          context: context,
          builder: (contextDialog) {
            return SuccessDialog('Transação gravada.');
          });
      Navigator.pop(context);
    }
  }

  void _showErro(BuildContext context, {String mensagem = 'Erro inesperado.'}) {
    showDialog(
        context: context,
        builder: (contextDialog) {
          return FailureDialog(mensagem);
        });
  }
}
