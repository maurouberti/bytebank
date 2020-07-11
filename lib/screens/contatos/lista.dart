import 'package:bytebank/models/contato.dart';
import 'package:bytebank/screens/contatos/formulario.dart';
import 'package:bytebank/screens/contatos/formulario_transacao.dart';
import 'package:bytebank/widgets/app_dependencies.dart';
import 'package:flutter/material.dart';

const _tituloAppBar = 'Contatos';

class ListaContatos extends StatefulWidget {
  @override
  _ListaContatosState createState() => _ListaContatosState();
}

class _ListaContatosState extends State<ListaContatos> {
  @override
  Widget build(BuildContext context) {
    final dependencies = AppDependencies.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(_tituloAppBar)),
      body: FutureBuilder<List<Contato>>(
        initialData: List(),
        future: dependencies.contatoDao.findAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              Center(child: CircularProgressIndicator());
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              final List<Contato> contatos = snapshot.data;
              return ListView.builder(
                itemCount: contatos.length,
                itemBuilder: (context, indice) {
                  final Contato contato = contatos[indice];
                  return ItemContato(contato, onClick: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => FormularioTransacao(contato)));
                  });
                },
              );
              break;
          }
          return Text('Erro!');
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => FormularioContato(),
            ),
          );
        },
      ),
    );
  }
}

class ItemContato extends StatelessWidget {
  final Contato contato;
  final Function onClick;

  const ItemContato(this.contato, {@required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => onClick(),
        leading: Icon(Icons.monetization_on),
        title: Text(contato.nome),
        subtitle: Text(contato.numeroConta.toString()),
      ),
    );
  }
}
