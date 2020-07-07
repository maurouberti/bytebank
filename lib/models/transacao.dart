import 'contato.dart';

class Transacao {
  final double valor;
  final Contato contato;

  Transacao(
    this.valor,
    this.contato,
  );

  Transacao.fromJson(Map<String, dynamic> json)
      : valor = (json['valor']).toDouble(),
        contato = Contato.fromJson(json['contato']);

  Map<String, dynamic> toJson() => {
        'valor': valor,
        'contato': contato.toJson(),
      };

  @override
  String toString() {
    return 'Transacao{valor: $valor, contato: $contato}';
  }
}
