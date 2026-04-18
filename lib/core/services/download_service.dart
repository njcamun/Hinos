import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import '../../data/models/hino_model.dart';
import '../../data/repositories/hinos_repository.dart';

class DownloadService {
  final Dio _dio = Dio();
  final HinosRepository _repository;

  DownloadService(this._repository);

  Future<void> downloadAudio(Hino hino, Function(double) onProgress) async {
    if (hino.audioUrl == null || hino.audioUrl!.isEmpty) return;

    try {
      final dir = await getApplicationDocumentsDirectory();
      final savePath = '${dir.path}/audio_${hino.numero}.mp3';

      await _dio.download(
        hino.audioUrl!,
        savePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            onProgress(received / total);
          }
        },
      );

      // Atualiza o hino no banco de dados
      hino.audioLocalPath = savePath;
      hino.isDownloaded = true;
      await _repository.updateHino(hino);
    } catch (e) {
      debugPrint("Erro no download: $e");
      rethrow;
    }
  }

  Future<void> deleteDownload(Hino hino) async {
    if (hino.audioLocalPath != null) {
      final file = File(hino.audioLocalPath!);
      if (await file.exists()) {
        await file.delete();
      }
      hino.audioLocalPath = null;
      hino.isDownloaded = false;
      await _repository.updateHino(hino);
    }
  }
}
