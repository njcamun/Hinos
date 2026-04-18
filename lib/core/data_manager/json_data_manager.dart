// lib/core/data_manager/json_data_manager.dart
import 'dart:convert'; // Para jsonEncode e jsonDecode
import 'dart:io'; // Para File
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle; // Para carregar assets
import 'package:path_provider/path_provider.dart'; // Para obter diretórios do app
import 'package:path/path.dart'; // Para join
import 'package:synchronized/synchronized.dart';

class JsonDataManager {
  static final JsonDataManager _instance = JsonDataManager._internal();
  factory JsonDataManager() => _instance;
  JsonDataManager._internal();

  // Mapeia os nomes dos ficheiros JSON e seus caminhos no diretório de documentos
  final Map<String, String> _filePaths = {
    'hinos': '',
    'dicionario': '',
    // 'favoritos': '', // Adicionar se favoritarmos num ficheiro separado
  };

  // NOVO: Adicione locks para operações de escrita em ficheiros JSON
  final Map<String, Lock> _fileLocks = {
    'hinos': Lock(),
    'dicionario': Lock(),
  };


  // Inicializa o Data Manager, copiando ficheiros assets para o diretório de documentos
  Future<void> initialize() async {
    final appDocDir = await getApplicationDocumentsDirectory();
    final dataDirPath = join(appDocDir.path, 'data'); // Sub-pasta 'data' dentro dos documentos
    await Directory(dataDirPath).create(recursive: true); // Cria a pasta se não existir

    // Ficheiros a copiar e gerir
    final fileNames = ['hinos.json', 'dicionario.json'];

    for (var fileName in fileNames) {
      final assetPath = 'assets/data/$fileName';
      final localPath = join(dataDirPath, fileName);
      _filePaths[fileName.split('.').first] = localPath; // Guarda o caminho local

      final localFile = File(localPath);

      // Copia o ficheiro do assets apenas se não existir ou se for uma atualização (opcional)
      if (!await localFile.exists()) {
        debugPrint('JsonDataManager: Copiando $fileName de assets para $localPath');
        final String jsonString = await rootBundle.loadString(assetPath);
        await localFile.writeAsString(jsonString, flush: true);
      } else {
        debugPrint('JsonDataManager: $fileName já existe em $localPath');
      }
    }
    debugPrint('JsonDataManager: Inicialização concluída.');
  }

  // Função genérica para ler um ficheiro JSON
  Future<List<Map<String, dynamic>>?> readJsonFile(String key) async {
    final path = _filePaths[key];
    if (path == null) {
      debugPrint('JsonDataManager: Caminho para $key.json não encontrado.');
      return null;
    }
    try {
      final file = File(path);
      if (!await file.exists()) {
        debugPrint('JsonDataManager: Ficheiro $key.json não encontrado em $path.');
        return null;
      }
      final String jsonString = await file.readAsString();
      return (json.decode(jsonString) as List).cast<Map<String, dynamic>>();
    } catch (e) {
      debugPrint('JsonDataManager: Erro ao ler $key.json: $e');
      return null;
    }
  }

  // Função genérica para escrever (sobrescrever) um ficheiro JSON
  Future<void> writeJsonFile(String key, List<Map<String, dynamic>> data) async {
    final path = _filePaths[key];
    final lock = _fileLocks[key];
    if (path == null || lock == null) {
      debugPrint('JsonDataManager: Caminho ou lock para $key.json não encontrado.');
      return;
    }
    await lock.synchronized(() async { // NOVO: Usa lock para garantir escrita segura
      try {
        final file = File(path);
        final String jsonString = json.encode(data);
        await file.writeAsString(jsonString, flush: true);
        debugPrint('JsonDataManager: $key.json salvo com sucesso em $path');
      } catch (e) {
        debugPrint('JsonDataManager: Erro ao escrever $key.json: $e');
      }
    });
  }
}