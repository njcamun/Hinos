import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter/services.dart';

import '../database/app_database.dart' as db;
import '../../data/models/hino_model.dart';
import '../../data/models/dicionario_model.dart';

class DatabaseService {
  final db.AppDatabase database = db.AppDatabase();

  Future<void> init() async {
    if (!await database.hasHinos) {
      await _importHinos();
    }

    if (!await database.hasPalavraDicionarios) {
      await _importDicionario();
    }
  }

  Future<void> _importHinos() async {
    final String response = await rootBundle.loadString('assets/data/hinos.json');
    final List<dynamic> data = json.decode(response);
    final hinos = data
        .map((e) => Hino.fromJson(e as Map<String, dynamic>))
        .map((hino) => db.HinosCompanion.insert(
              numero: hino.numero,
              titulo: hino.titulo,
              letra: hino.letra,
              autor: Value(hino.autor),
              audioUrl: Value(hino.audioUrl),
              audioLocalPath: Value(hino.audioLocalPath),
              isFavorito: Value(hino.isFavorito),
              isDownloaded: Value(hino.isDownloaded),
            ))
        .toList();

    await database.insertHinos(hinos);
  }

  Future<void> _importDicionario() async {
    final String response = await rootBundle.loadString('assets/data/dicionario.json');
    final List<dynamic> data = json.decode(response);
    final palavras = data
        .map((e) => PalavraDicionario.fromJson(e as Map<String, dynamic>))
        .map((palavra) => db.PalavraDicionariosCompanion.insert(
              palavra: palavra.palavra,
              idioma: palavra.idioma,
              explicacao: Value(palavra.explicacao),
              exemploUso: Value(palavra.exemploUso),
              hinoIdRelacionado: Value(palavra.hinoIdRelacionado),
            ))
        .toList();

    await database.insertPalavraDicionarios(palavras);
  }
}
