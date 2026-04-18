import 'package:drift/drift.dart';

import '../../core/database/app_database.dart' as db;
import '../models/hino_model.dart';

class HinosRepository {
  final db.AppDatabase database;

  HinosRepository(this.database);

  Hino _mapHino(db.HinoData row) {
    return Hino()
      ..id = row.id
      ..numero = row.numero
      ..titulo = row.titulo
      ..letra = row.letra
      ..autor = row.autor
      ..audioUrl = row.audioUrl
      ..audioLocalPath = row.audioLocalPath
      ..isFavorito = row.isFavorito
      ..isDownloaded = row.isDownloaded;
  }

  db.HinosCompanion _toCompanion(Hino hino) {
    return db.HinosCompanion(
      id: hino.id == null ? const Value.absent() : Value(hino.id!),
      numero: Value(hino.numero),
      titulo: Value(hino.titulo),
      letra: Value(hino.letra),
      autor: Value(hino.autor),
      audioUrl: Value(hino.audioUrl),
      audioLocalPath: Value(hino.audioLocalPath),
      isFavorito: Value(hino.isFavorito),
      isDownloaded: Value(hino.isDownloaded),
    );
  }

  Future<List<Hino>> getAllHinos() async {
    final rows = await (database.select(database.hinos)
          ..orderBy([
            (t) => OrderingTerm(expression: t.numero),
          ]))
        .get();
    return rows.map(_mapHino).toList();
  }

  Future<List<Hino>> searchHinos(String query) async {
    if (query.isEmpty) return getAllHinos();
    final lowerQuery = query.toLowerCase();

    final rows = await (database.select(database.hinos)
          ..where((tbl) => tbl.titulo.lower().like('%$lowerQuery%') |
              tbl.letra.lower().like('%$lowerQuery%'))
          ..orderBy([
            (t) => OrderingTerm(expression: t.numero),
          ]))
        .get();

    return rows.map(_mapHino).toList();
  }

  Future<List<Hino>> getFavoritos() async {
    final rows = await (database.select(database.hinos)
          ..where((tbl) => tbl.isFavorito.equals(true))
          ..orderBy([
            (t) => OrderingTerm(expression: t.numero),
          ]))
        .get();
    return rows.map(_mapHino).toList();
  }

  Future<void> toggleFavorito(Hino hino) async {
    final updatedHino = Hino()
      ..id = hino.id
      ..numero = hino.numero
      ..titulo = hino.titulo
      ..letra = hino.letra
      ..autor = hino.autor
      ..audioUrl = hino.audioUrl
      ..audioLocalPath = hino.audioLocalPath
      ..isFavorito = !hino.isFavorito
      ..isDownloaded = hino.isDownloaded;

    await database.into(database.hinos).insertOnConflictUpdate(_toCompanion(updatedHino));
  }

  Stream<List<Hino>> watchHinos() {
    return (database.select(database.hinos)
          ..orderBy([
            (t) => OrderingTerm(expression: t.numero),
          ]))
        .watch()
        .map((rows) => rows.map(_mapHino).toList());
  }

  Future<void> updateHino(Hino hino) async {
    await database.into(database.hinos).insertOnConflictUpdate(_toCompanion(hino));
  }
}
