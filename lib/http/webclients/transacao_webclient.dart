import 'dart:convert';

import 'package:bytebank/http/webclient.dart';
import 'package:bytebank/models/transacao.dart';
import 'package:http/http.dart';

class TransacaoWebClient {
  Future<List<Transacao>> findAll() async {
    final Response response =
        await client.get(baseUrl);
    final List<dynamic> decodeJson = jsonDecode(response.body);
    return decodeJson.map((dynamic json) => Transacao.fromJson(json)).toList();
  }

  Future<int> save(Transacao transacao, String password) async {

    // simular
    await Future.delayed(  Duration(seconds: 5));

    final String transacaoJson = jsonEncode(transacao.toJson());
    final Response response = await client.post(
      baseUrl,
      headers: {
        'Content-type': 'application/json',
        'password': password,
      },
      body: transacaoJson,
    );

    if (response.statusCode == 201) {
      return 201;
    }

    throw MyHttpException(_getMessage(response.statusCode));
  }

  String _getMessage(int statusCode) {
    if (_statusCodeResponses.containsKey(statusCode)) {
      return _statusCodeResponses[statusCode];
    }
    return 'Erro não identificado.';
  }

  static final Map<int, String> _statusCodeResponses = {
    400: 'Erro ao submeter transação.',
    401: 'Erro na autenticação.',
    409: 'Transação já existe.',
    422: 'Valor inválido.'
  };
}

class MyHttpException implements Exception {
  final String message;
  MyHttpException(this.message);
}