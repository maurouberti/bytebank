import 'package:bytebank/database/dao/contato_dao.dart';
import 'package:bytebank/http/webclients/transacao_webclient.dart';
import 'package:bytebank/screens/menu/menu.dart';
import 'package:bytebank/widgets/app_dependencies.dart';
import 'package:flutter/material.dart';

void main() => runApp(ByteBankApp(
      contatoDao: ContatoDao(),
      transacaoWebClient: TransacaoWebClient(),
    ));

class ByteBankApp extends StatelessWidget {
  final ContatoDao contatoDao;
  final TransacaoWebClient transacaoWebClient;

  const ByteBankApp({
    @required this.contatoDao,
    @required this.transacaoWebClient,
  });

  @override
  Widget build(BuildContext context) {
    return AppDependencies(
      contatoDao: contatoDao,
      transacaoWebClient: transacaoWebClient,
      child: MaterialApp(
        theme: ThemeData(
            primaryColor: Colors.green[900],
            accentColor: Colors.blueAccent[700],
            buttonTheme: ButtonThemeData(
                buttonColor: Colors.blueAccent[700],
                textTheme: ButtonTextTheme.primary)),
        home: Menu(),
      ),
    );
  }
}
