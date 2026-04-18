// lib/core/models/palavra_dicionario_model.dart
class PalavraDicionario {
  final int id;
  final String idioma;
  final String palavra;
  final String? exemploUso; // Pode ser nulo
  final String explicacao;

  PalavraDicionario({
    required this.id,
    required this.idioma,
    required this.palavra,
    this.exemploUso,
    required this.explicacao,
  });

  // Converte um Map (do banco de dados) em um objeto PalavraDicionario
  factory PalavraDicionario.fromMap(Map<String, dynamic> map) {
    return PalavraDicionario(
      id: map['id'] as int,
      idioma: map['idioma'] as String,
      palavra: map['palavra'] as String,
      exemploUso: map['exemplo_uso'] as String?,
      explicacao: map['explicacao'] as String,
    );
  }

  // Converte um objeto PalavraDicionario em um Map (para salvar no banco de dados)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idioma': idioma,
      'palavra': palavra,
      'exemplo_uso': exemploUso,
      'explicacao': explicacao,
    };
  }
}