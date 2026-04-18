import 'package:drift/drift.dart';

import '../../core/database/app_database.dart' as db;
import '../models/dicionario_model.dart';

class DictionaryRepository {
  final db.AppDatabase database;

  DictionaryRepository(this.database);

  PalavraDicionario _mapPalavra(db.PalavraDicionarioData row) {
    return PalavraDicionario()
      ..id = row.id
      ..palavra = row.palavra
      ..idioma = row.idioma
      ..explicacao = row.explicacao
      ..exemploUso = row.exemploUso
      ..hinoIdRelacionado = row.hinoIdRelacionado;
  }

  Future<List<PalavraDicionario>> getAllPalavras() async {
    final rows = await (database.select(database.palavraDicionarios)
          ..orderBy([
            (t) => OrderingTerm(expression: t.palavra),
          ]))
        .get();
    return rows.map(_mapPalavra).toList();
  }

  Future<List<PalavraDicionario>> searchPalavras(String query) async {
    if (query.isEmpty) return getAllPalavras();
    final lowerQuery = query.toLowerCase();

    final rows = await (database.select(database.palavraDicionarios)
          ..where((tbl) => tbl.palavra.lower().like('%$lowerQuery%') |
              tbl.explicacao.lower().like('%$lowerQuery%'))
          ..orderBy([
            (t) => OrderingTerm(expression: t.palavra),
          ]))
        .get();
    return rows.map(_mapPalavra).toList();
  }
}
