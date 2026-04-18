class Hino {
  int? id;
  late int numero;
  late String titulo;
  late String letra;
  String? autor;
  String? audioUrl;
  String? audioLocalPath;
  bool isFavorito = false;
  bool isDownloaded = false;

  Hino();

  factory Hino.fromJson(Map<String, dynamic> json) {
    return Hino()
      ..id = json['id'] as int?
      ..numero = json['numero'] ?? 0
      ..titulo = json['titulo'] ?? ''
      ..letra = json['letra'] ?? ''
      ..autor = json['autor'] ?? 'Desconhecido'
      ..audioUrl = json['audio_url'] ?? ''
      ..audioLocalPath = json['audio_local_path'] ?? ''
      ..isFavorito = (json['is_favorito'] == 1 || json['is_favorito'] == true)
      ..isDownloaded = (json['is_downloaded'] == 1 || json['is_downloaded'] == true);
  }
}
