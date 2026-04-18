// lib/core/data_manager/json_data_manager.dart
import 'dart:convert';
import 'dart:io' show File, Directory;
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:synchronized/synchronized.dart';

class JsonDataManager {
  static final JsonDataManager _instance = JsonDataManager._internal();
  factory JsonDataManager() => _instance;
  JsonDataManager._internal();

  final Map<String, String> _filePaths = {
    'hinos': '',
    'dicionario': '',
  };

  final Map<String, Lock> _fileLocks = {
    'hinos': Lock(),
    'dicionario': Lock(),
  };

  Future<void> initialize() async {
    if (kIsWeb) {
      debugPrint('JsonDataManager: Rodando na Web, leitura via assets.');
      return;
    }

    final appDocDir = await getApplicationDocumentsDirectory();
    final dataDirPath = join(appDocDir.path, 'data');
    await Directory(dataDirPath).create(recursive: true);

    final fileNames = ['hinos.json', 'dicionario.json'];

    for (var fileName in fileNames) {
      final assetPath = 'assets/data/$fileName';
      final localPath = join(dataDirPath, fileName);
      _filePaths[fileName.split('.').first] = localPath;

      final localFile = File(localPath);

      if (!await localFile.exists()) {
        debugPrint('JsonDataManager: Copiando $fileName de assets para $localPath');
        final String jsonString = await rootBundle.loadString(assetPath);
        await localFile.writeAsString(jsonString, flush: true);
      }
    }
    debugPrint('JsonDataManager: Inicialização Mobile concluída.');
  }

  Future<List<Map<String, dynamic>>?> readJsonFile(String key) async {
    if (kIsWeb) {
      try {
        final assetPath = 'assets/data/$key.json';
        final String jsonString = await rootBundle.loadString(assetPath);
        return (json.decode(jsonString) as List).cast<Map<String, dynamic>>();
      } catch (e) {
        debugPrint('JsonDataManager Web: Erro ao ler $key.json dos assets: $e');
        return null;
      }
    }

    final path = _filePaths[key];
    if (path == null || path.isEmpty) return null;
    
    try {
      final file = File(path);
      if (!await file.exists()) return null;
      final String jsonString = await file.readAsString();
      return (json.decode(jsonString) as List).cast<Map<String, dynamic>>();
    } catch (e) {
      debugPrint('JsonDataManager: Erro ao ler $key.json: $e');
      return null;
    }
  }

  Future<void> writeJsonFile(String key, List<Map<String, dynamic>> data) async {
    if (kIsWeb) {
      debugPrint('JsonDataManager: Escrita de ficheiros não suportada na Web.');
      return;
    }

    final path = _filePaths[key];
    final lock = _fileLocks[key];
    if (path == null || path.isEmpty || lock == null) return;
    
    await lock.synchronized(() async {
      try {
        final file = File(path);
        final String jsonString = json.encode(data);
        await file.writeAsString(jsonString, flush: true);
      } catch (e) {
        debugPrint('JsonDataManager: Erro ao escrever $key.json: $e');
      }
    });
  }
}
