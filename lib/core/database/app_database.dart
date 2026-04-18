import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

@DataClassName('HinoData')
class Hinos extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get numero => integer().unique()();
  TextColumn get titulo => text()();
  TextColumn get letra => text()();
  TextColumn get autor => text().nullable()();
  TextColumn get audioUrl => text().nullable()();
  TextColumn get audioLocalPath => text().nullable()();
  BoolColumn get isFavorito => boolean().withDefault(const Constant(false))();
  BoolColumn get isDownloaded => boolean().withDefault(const Constant(false))();
}

@DataClassName('PalavraDicionarioData')
class PalavraDicionarios extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get palavra => text()();
  TextColumn get idioma => text()();
  TextColumn get explicacao => text().nullable()();
  TextColumn get exemploUso => text().nullable()();
  IntColumn get hinoIdRelacionado => integer().nullable()();
}

@DriftDatabase(tables: [Hinos, PalavraDicionarios])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  static LazyDatabase _openConnection() {
    return LazyDatabase(() async {
      final dir = await getApplicationDocumentsDirectory();
      final file = File(p.join(dir.path, 'harpa_crista_angolana.db'));
      return NativeDatabase(file);
    });
  }

  @override
  int get schemaVersion => 1;

  Future<bool> get hasHinos async => (await select(hinos).get()).isNotEmpty;
  Future<bool> get hasPalavraDicionarios async => (await select(palavraDicionarios).get()).isNotEmpty;

  Future<void> insertHinos(List<HinosCompanion> entries) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(hinos, entries);
    });
  }

  Future<void> insertPalavraDicionarios(List<PalavraDicionariosCompanion> entries) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(palavraDicionarios, entries);
    });
  }
}
