import 'package:bytebank/components/botao.dart';
import 'package:bytebank/components/editor.dart';
import 'package:bytebank/http/webclients/transacao_webclient.dart';
import 'package:bytebank/models/contato.dart';
import 'package:bytebank/models/transacao.dart';
import 'package:flutter/material.dart';

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
  final TransacaoWebClient _webClient = TransacaoWebClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_tituloAppBar)),
      body: ListView(
        children: <Widget>[
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
              final transacaoCriada = Transacao(valor, widget.contato);
              _webClient.save(transacaoCriada).then((int statusCode) {
                if (statusCode == 201) {
                  Navigator.pop(context);
                }
              });
            },
          ),
        ],
      ),
    );
  }
}
