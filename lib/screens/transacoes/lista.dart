import 'package:bytebank/components/mensagem.dart';
import 'package:bytebank/http/webclients/transacao_webclient.dart';
import 'package:bytebank/models/transacao.dart';
import 'package:flutter/material.dart';

class ListaTransacoes extends StatelessWidget {

  final TransacaoWebClient _webClient = TransacaoWebClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transações'),
      ),
      body: FutureBuilder(
        future: _webClient.findAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              if (snapshot.hasData) {
                final List<Transacao> transacoes = snapshot.data;
                if (transacoes.isNotEmpty) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final Transacao transacao = transacoes[index];
                      return Card(
                        child: ListTile(
                          leading: Icon(Icons.monetization_on),
                          title: Text(
                            transacao.valor.toString(),
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            transacao.contato.numeroConta.toString(),
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: transacoes.length,
                  );
                }
              }
              return Mensagem('Não existe nenhuma transação', icon: Icons.warning,);
              break;
          }
          return Mensagem('Erro');
        },
      ),
    );
  }
}
