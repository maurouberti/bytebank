

import 'package:bytebank/models/transacao.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Deve retornar o valor quando uma transação for criada.', () {
    final Transacao transacao = Transacao(null, 200, null);
    expect(transacao.valor, 200);
  });

  test('Deve retornar erro quando a transação for menor ou igual a zero.', () {
    expect(() => Transacao(null, 0, null), throwsAssertionError);
  });
}