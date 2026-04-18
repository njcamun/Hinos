class PalavraDicionario {
  int? id;
  late String palavra;
  late String idioma;
  String? explicacao;
  String? exemploUso;
  int? hinoIdRelacionado;

  PalavraDicionario();

  factory PalavraDicionario.fromJson(Map<String, dynamic> json) {
    return PalavraDicionario()
      ..id = json['id'] as int?
      ..palavra = json['palavra'] ?? ''
      ..idioma = json['idioma'] ?? ''
      ..explicacao = json['explicacao']
      ..exemploUso = json['exemplo_uso']
      ..hinoIdRelacionado = json['hino_id_relacionado'];
  }
}
