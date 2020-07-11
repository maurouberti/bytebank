import 'contato.dart';

class Transacao {
  final String uuid;
  final double valor;
  final Contato contato;

  Transacao(
    this.uuid,
    this.valor,
    this.contato,
  ) : assert(valor > 0);

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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Transacao &&
          runtimeType == other.runtimeType &&
          valor == other.valor &&
          contato == other.contato;

  @override
  int get hashCode => valor.hashCode ^ contato.hashCode;
}
