import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import '../../data/models/hino_model.dart';

class AudioService {
  final AudioPlayer _player = AudioPlayer();

  AudioPlayer get player => _player;

  Future<void> playHino(Hino hino) async {
    try {
      final source = hino.audioLocalPath != null && hino.isDownloaded
          ? AudioSource.file(
              hino.audioLocalPath!,
              tag: MediaItem(
                id: hino.id.toString(),
                album: "Harpa Cristã Angolana",
                title: hino.titulo,
                artist: hino.autor,
              ),
            )
          : AudioSource.uri(
              Uri.parse(hino.audioUrl!),
              tag: MediaItem(
                id: hino.id.toString(),
                album: "Harpa Cristã Angolana",
                title: hino.titulo,
                artist: hino.autor,
              ),
            );

      await _player.setAudioSource(source);
      _player.play();
    } catch (e) {
      debugPrint("Erro ao tocar áudio: $e");
    }
  }

  Future<void> stop() async => await _player.stop();
  Future<void> pause() async => await _player.pause();
  Future<void> resume() async => await _player.play();
  
  void dispose() {
    _player.dispose();
  }
}
