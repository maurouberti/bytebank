import 'package:bytebank/components/botao.dart';
import 'package:bytebank/components/response_dialog.dart';
import 'package:bytebank/components/transacao_auth_dialog.dart';
import 'package:bytebank/main.dart';
import 'package:bytebank/models/contato.dart';
import 'package:bytebank/models/transacao.dart';
import 'package:bytebank/screens/contatos/formulario_transacao.dart';
import 'package:bytebank/screens/contatos/lista.dart';
import 'package:bytebank/screens/menu/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../matches/matchers.dart';
import '../mocks/mockes.dart';

void main() {
  testWidgets('Deve transferir para o contato', (tester) async {
    final mockContatoDao = MockContatoDao();
    final mockTransacaoWebClient = MockTransacaoWebClient();

    await tester.pumpWidget(ByteBankApp(
      contatoDao: mockContatoDao,
      transacaoWebClient: mockTransacaoWebClient,
    ));

    /** encontra o menu */
    final menu = find.byType(Menu);
    expect(menu, findsOneWidget);

    /** monta o findAll() */
    final Contato mauro = Contato(0, 'Mauro', 1000);
    when(mockContatoDao.findAll()).thenAnswer((invocation) async => [mauro]);

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

    /** encontra item (contato) */
    final itemContato = find.byWidgetPredicate((widget) {
      if (widget is ItemContato) {
        return widget.contato.nome == 'Mauro' &&
            widget.contato.numeroConta == 1000;
      }
      return false;
    });
    expect(itemContato, findsOneWidget);

    /** clica no item */
    await tester.tap(itemContato);

    /** aguarda renderizar tela */
    await tester.pumpAndSettle();

    /** encontra o formulario de transação */
    final formTransacao = find.byType(FormularioTransacao);
    expect(formTransacao, findsOneWidget);

    /** encontra o nome */
    final contatoNome = find.text('Mauro');
    expect(contatoNome, findsOneWidget);

    /** encontra número de conta */
    final contatoNumeroConta = find.text('1000');
    expect(contatoNumeroConta, findsOneWidget);

    /** encontra o input valor */
    final editorValor = find.byWidgetPredicate((widget) {
      return editorMatcher(widget, 'Valor da transação');
    });
    expect(editorValor, findsOneWidget);

    /** entra com valor */
    await tester.enterText(editorValor, '200');

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

    /** encontrar tela de senha */
    final transacaoAuthDialog = find.byType(TransacaoAuthDialog);
    expect(transacaoAuthDialog, findsOneWidget);

    /** encontra o input password */
    final textFieldPassword =
        find.byKey(transacaoAuthDialogTextFieldPasswordKey);
    expect(textFieldPassword, findsOneWidget);

    /** entra com password */
    await tester.enterText(textFieldPassword, '1000');

    /** encontra botão cancelar */
    final botaoCancelar = find.widgetWithText(FlatButton, 'Cancelar');
    expect(botaoCancelar, findsOneWidget);

    /** encontra botão confirmar */
    final botaoConfirmar = find.widgetWithText(FlatButton, 'Confirmar');
    expect(botaoConfirmar, findsOneWidget);

    /** monta o salvar */
    when(mockTransacaoWebClient.save(Transacao(null, 200, mauro), '1000'))
        .thenAnswer((_) async => 201);

    /** clica en confirmar */
    await tester.tap(botaoConfirmar);

    /** aguarda renderiza tela */
    await tester.pumpAndSettle();

    /** tela de sucesso */
    final successDialog = find.byType(SuccessDialog);
    expect(successDialog, findsOneWidget);

    /** encontrar botao em ok */
    final okButton = find.widgetWithText(FlatButton, 'Ok');
    expect(okButton, findsOneWidget);

    /** clicar em ok */
    await tester.tap(okButton);

    /** aguarda renderiza tela */
    await tester.pumpAndSettle();

    /** verificar se retorna a lista */
    final listaContatosBack = find.byType(ListaContatos);
    expect(listaContatosBack, findsOneWidget);
  });
}
