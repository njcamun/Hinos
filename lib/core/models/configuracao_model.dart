// lib/core/models/configuracao_model.dart
class Configuracao {
  final bool isDarkMode;
  final double fontSizeFactor;

  Configuracao({required this.isDarkMode, required this.fontSizeFactor});

// Se precisar de converter de/para JSON ou Map, adicione aqui
// factory Configuracao.fromJson(Map<String, dynamic> json) => Configuracao(...)
// Map<String, dynamic> toJson() => {...}
}