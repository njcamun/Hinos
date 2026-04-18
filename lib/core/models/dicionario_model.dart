// lib/core/models/dicionario_model.dart
class DicionarioEntry {
  final int id;
  final String idioma;
  final String palavra;
  final String exemploUso;
  final String explicacao;

  DicionarioEntry({
    required this.id,
    required this.idioma,
    required this.palavra,
    required this.exemploUso,
    required this.explicacao,
  });

  // Construtor factory para criar uma instância de DicionarioEntry a partir de um Map (JSON)
  factory DicionarioEntry.fromJson(Map<String, dynamic> json) {
    return DicionarioEntry(
      id: json['id'] as int,
      idioma: json['idioma'] as String,
      palavra: json['palavra'] as String,
      exemploUso: json['exemplo_uso'] as String? ?? '', // Garante que é String ou vazio
      explicacao: json['explicacao'] as String,
    );
  }

  // Método para converter uma instância de DicionarioEntry para Map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'idioma': idioma,
      'palavra': palavra,
      'exemplo_uso': exemploUso,
      'explicacao': explicacao,
    };
  }
}