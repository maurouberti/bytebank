import 'contato.dart';

class Transacao {
  final String uuid;
  final double valor;
  final Contato contato;

  Transacao(
    this.uuid,
    this.valor,
    this.contato,
  );

  Transacao.fromJson(Map<String, dynamic> json)
      : uuid = json['uuid'],
        valor = (json['valor']).toDouble(),
        contato = Contato.fromJson(json['contato']);

  Map<String, dynamic> toJson() => {
        'uuid': uuid,
        'valor': valor,
        'contato': contato.toJson(),
      };

  @override
  String toString() {
    return 'Transacao{uuid: $uuid, valor: $valor, contato: $contato}';
  }
}
