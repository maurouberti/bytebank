import 'package:bytebank/screens/contatos/lista.dart';
import 'package:bytebank/screens/transacoes/lista.dart';
import 'package:flutter/material.dart';

class Menu extends StatefulWidget {

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 40.0, 8.0, 8.0),
                  child: Image.asset('images/bytebank_logo.png'),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: <Widget>[
                      BotaoMenu(
                        textoBotao: 'Transações',
                        icone: Icons.description,
                        onClick: (context) => ListaTransacoes(),
                      ),
                      BotaoMenu(
                        textoBotao: 'Contatos',
                        icone: Icons.people,
                        onClick: (context) =>
                            ListaContatos(),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BotaoMenu extends StatelessWidget {
  final String textoBotao;
  final Function(BuildContext) onClick;
  final IconData icone;

  const BotaoMenu(
      {Key key, this.textoBotao, @required this.onClick, this.icone})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).primaryColor,
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: onClick,
            ));
          },
          child: Container(
            padding: EdgeInsets.all(8.0),
            height: 100,
            width: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(
                  icone,
                  color: Theme.of(context).primaryIconTheme.color,
                  size: 24.0,
                ),
                Text(
                  textoBotao,
                  style: TextStyle(
                    color: Theme.of(context).primaryTextTheme.bodyText1.color,
                    fontSize: 16.0,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
