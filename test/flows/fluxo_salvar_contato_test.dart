import 'package:bytebank/components/botao.dart';
import 'package:bytebank/main.dart';
import 'package:bytebank/models/contato.dart';
import 'package:bytebank/screens/contatos/formulario.dart';
import 'package:bytebank/screens/contatos/lista.dart';
import 'package:bytebank/screens/menu/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../matches/matchers.dart';
import '../mocks/mockes.dart';

void main() {
  testWidgets('Deve salvar um contato', (tester) async {
    final mockContatoDao = MockContatoDao();
    await tester.pumpWidget(ByteBankApp(
      contatoDao: mockContatoDao,
      transacaoWebClient: null,
    ));

    /** encontra o menu */
    final menu = find.byType(Menu);
    expect(menu, findsOneWidget);

    /** encontra o botão */
    final botaoMenu = find.byWidgetPredicate((widget) {
      return botaMenuMatcher(widget, 'Contatos', Icons.people);
    });
    expect(botaoMenu, findsOneWidget);

    /** clica no botão */
    await tester.tap(botaoMenu);

    /** aguarda renderiza tela - antes de abrir nova tela */
    await tester.pumpAndSettle();

    /** encontra a lista de contatos */
    final listaContatos = find.byType(ListaContatos);
    expect(listaContatos, findsOneWidget);

    /** verificar lista de contatos */
    verify(mockContatoDao.findAll()).called(1);

    /** encontra botão */
    final fabNovoContato = find.byType(FloatingActionButton);
    expect(fabNovoContato, findsOneWidget);

    /** clica no botão */
    await tester.tap(fabNovoContato);

    /** aguarda renderiza tela - antes de abrir nova tela */
    await tester.pumpAndSettle();

    /** encontra formulario */
    final formulario = find.byType(FormularioContato);
    expect(formulario, findsOneWidget);

    /** encontra o input nome */
    final editorNome = find.byWidgetPredicate((widget) {
      return editorMatcher(widget, 'Nome');
    });
    expect(editorNome, findsOneWidget);

    /** entra com texto */
    await tester.enterText(editorNome, 'Mauro');

    /** encontra o input conta */
    final editorConta = find.byWidgetPredicate((widget) {
      return editorMatcher(widget, 'Número da conta');
    });
    expect(editorConta, findsOneWidget);

    /** entra com texto */
    await tester.enterText(editorConta, '1000');

    /** encontra botão */
    final botao = find.byWidgetPredicate((widget) {
      if (widget is Botao) {
        return widget.textoBotao == 'Confirmar';
      }
      return false;
    });
    expect(botao, findsOneWidget);

    /** clicar no botão */
    await tester.tap(botao);

    /** aguarda renderiza tela - antes de abrir nova tela */
    await tester.pumpAndSettle();

    /** verificar savar de contatos */
    verify(mockContatoDao.save(Contato(0, 'Mauro', 1000)));

    /** encontra lista de contato */
    final listaContarosBack = find.byType(ListaContatos);
    expect(listaContarosBack, findsOneWidget);

    /** verificar se retorna a lista */
    // verify(mockContatoDao.findAll());

  });
}
