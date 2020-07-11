import 'package:bytebank/screens/menu/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../matches/matchers.dart';

void main() {
  testWidgets('Deve mostrar a imagem quando o menu for aberto.',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Menu()));
    final imagem = find.byType(Image);
    expect(imagem, findsOneWidget);
  });

  testWidgets('Deve verificar as características do primeiro botão MODELO 1.',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Menu()));

    final primeiroBotao = find.byType(BotaoMenu);
    expect(primeiroBotao, findsWidgets);

    final iconeBotao = find.widgetWithIcon(BotaoMenu, Icons.description);
    expect(iconeBotao, findsOneWidget);

    final textoBotao = find.widgetWithText(BotaoMenu, 'Transações');
    expect(textoBotao, findsOneWidget);
  });

  testWidgets('Deve verificar as características do segundo botão MODELO 1.',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Menu()));

    final iconeBotao = find.widgetWithIcon(BotaoMenu, Icons.people);
    expect(iconeBotao, findsOneWidget);

    final textoBotao = find.widgetWithText(BotaoMenu, 'Contatos');
    expect(textoBotao, findsOneWidget);
  });

  testWidgets('Deve verificar as características do primeiro botão MODELO 2.',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Menu()));

    final botaoMenu = find.byWidgetPredicate((widget) {
      return botaMenuMatcher(widget, 'Transações', Icons.description);
    });
    expect(botaoMenu, findsOneWidget);
  });

  testWidgets('Deve verificar as características do segundo botão MODELO 2.',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Menu()));

    final botaoMenu = find.byWidgetPredicate((widget) {
      return botaMenuMatcher(widget, 'Contatos', Icons.people);
    });
    expect(botaoMenu, findsOneWidget);
  });
}
