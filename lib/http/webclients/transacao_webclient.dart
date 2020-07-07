import 'dart:convert';

import 'package:bytebank/http/webclient.dart';
import 'package:bytebank/models/transacao.dart';
import 'package:http/http.dart';

class TransacaoWebClient {
  Future<List<Transacao>> findAll() async {
    final Response response =
        await client.get(baseUrl).timeout(Duration(seconds: 5));
    final List<dynamic> decodeJson = jsonDecode(response.body);
    return decodeJson.map((dynamic json) => Transacao.fromJson(json)).toList();
  }

  Future<int> save(Transacao transacao) async {
    final String transacaoJson = jsonEncode(transacao.toJson());
    final Response response = await client.post(baseUrl,
        headers: {
          'Content-type': 'application/json',
        },
        body: transacaoJson);
    return response.statusCode;
    // return Transacao.fromJson(jsonDecode(response.body));
  }
}
