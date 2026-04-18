// lib/core/models/hino_model.dart
import 'package:flutter/material.dart'; // Mantenha, se precisar de MaterialColor

class Hino {
  final int id;
  final int numero;
  final String titulo;
  final String autor;
  final String letra;
  final String audioUrl;
  bool isDownloaded;
  bool isFavorito;

  Hino({
    required this.id,
    required this.numero,
    required this.titulo,
    required this.autor,
    required this.letra,
    this.audioUrl = '',
    this.isDownloaded = false,
    this.isFavorito = false,
  });

  // NOVO: Construtor factory para criar uma instância de Hino a partir de um Map (JSON)
  factory Hino.fromJson(Map<String, dynamic> json) {
    return Hino(
      id: json['id'] as int,
      numero: json['numero'] as int,
      titulo: json['titulo'] as String,
      autor: json['autor'] as String,
      letra: json['letra'] as String,
      audioUrl: json['audio_url'] as String? ?? '', // Garante String ou vazio
      isDownloaded: (json['is_downloaded'] as int? ?? 0) == 1, // Converte int (0/1) para bool
      isFavorito: (json['is_favorito'] as int? ?? 0) == 1, // Converte int (0/1) para bool
    );
  }

  // NOVO: Método para converter uma instância de Hino para Map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'numero': numero,
      'titulo': titulo,
      'autor': autor,
      'letra': letra,
      'audio_url': audioUrl,
      'is_downloaded': isDownloaded ? 1 : 0, // Converte bool para int (0/1)
      'is_favorito': isFavorito ? 1 : 0, // Converte bool para int (0/1)
    };
  }

  // Método copyWith para criar uma nova instância com valores alterados
  Hino copyWith({
    int? id,
    int? numero,
    String? titulo,
    String? autor,
    String? letra,
    String? audioUrl,
    bool? isDownloaded,
    bool? isFavorito,
  }) {
    return Hino(
      id: id ?? this.id,
      numero: numero ?? this.numero,
      titulo: titulo ?? this.titulo,
      autor: autor ?? this.autor,
      letra: letra ?? this.letra,
      audioUrl: audioUrl ?? this.audioUrl,
      isDownloaded: isDownloaded ?? this.isDownloaded,
      isFavorito: isFavorito ?? this.isFavorito,
    );
  }
}