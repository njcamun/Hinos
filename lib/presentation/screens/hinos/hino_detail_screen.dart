import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import '../../providers/providers.dart';
import '../../providers/settings_provider.dart';
import '../../../data/models/hino_model.dart';
import '../../../core/services/audio_service.dart';
import '../../../core/services/download_service.dart';

class HinoDetailScreen extends ConsumerStatefulWidget {
  final Hino hino;
  const HinoDetailScreen({super.key, required this.hino});

  @override
  ConsumerState<HinoDetailScreen> createState() => _HinoDetailScreenState();
}

class _HinoDetailScreenState extends ConsumerState<HinoDetailScreen> {
  double _downloadProgress = 0;
  bool _isDownloading = false;

  @override
  Widget build(BuildContext context) {
    final audioService = ref.watch(audioServiceProvider);
    final downloadService = ref.watch(downloadServiceProvider);
    final hinoRepository = ref.watch(hinosRepositoryProvider);
    final fontSize = ref.watch(fontSizeProvider);
    final settingsService = ref.watch(settingsServiceProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Hino ${widget.hino.numero}'),
        actions: [
          IconButton(
            icon: Icon(widget.hino.isFavorito ? Icons.star : Icons.star_border),
            color: widget.hino.isFavorito ? Colors.amber : null,
            onPressed: () async {
              await hinoRepository.toggleFavorito(widget.hino);
              setState(() {});
            },
          ),
          PopupMenuButton<double>(
            icon: const Icon(Icons.text_fields),
            onSelected: (size) async {
              ref.read(fontSizeProvider.notifier).state = size;
              await settingsService.setFontSize(size);
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 14.0, child: Text('Letra Pequena')),
              const PopupMenuItem(value: 18.0, child: Text('Letra Normal')),
              const PopupMenuItem(value: 24.0, child: Text('Letra Grande')),
              const PopupMenuItem(value: 30.0, child: Text('Letra Extra Grande')),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      widget.hino.titulo,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1B5E20),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Text(
                      'Autor: ${widget.hino.autor ?? "Desconhecido"}',
                      style: const TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
                    ),
                  ),
                  const Divider(height: 40),
                  Text(
                    widget.hino.letra,
                    style: TextStyle(fontSize: fontSize, height: 1.5),
                  ),
                  const SizedBox(height: 120),
                ],
              ),
            ),
          ),
          _buildAudioPlayer(audioService, downloadService),
        ],
      ),
    );
  }

  Widget _buildAudioPlayer(AudioService audioService, DownloadService downloadService) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.05),
            blurRadius: 10,
            offset: Offset(0, -5),
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_isDownloading)
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: LinearProgressIndicator(
                  value: _downloadProgress,
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                ),
              ),
            // Barra de Progresso do Áudio
            StreamBuilder<Duration>(
              stream: audioService.player.positionStream,
              builder: (context, snapshot) {
                final position = snapshot.data ?? Duration.zero;
                final duration = audioService.player.duration ?? Duration.zero;
                return Column(
                  children: [
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        trackHeight: 4,
                        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
                        overlayShape: const RoundSliderOverlayShape(overlayRadius: 14),
                      ),
                      child: Slider(
                        activeColor: Theme.of(context).primaryColor,
                        inactiveColor: Colors.grey[300],
                        max: duration.inMilliseconds.toDouble(),
                        value: position.inMilliseconds.toDouble().clamp(0, duration.inMilliseconds.toDouble()),
                        onChanged: (value) {
                          audioService.player.seek(Duration(milliseconds: value.toInt()));
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(_formatDuration(position), style: const TextStyle(fontSize: 12)),
                          Text(_formatDuration(duration), style: const TextStyle(fontSize: 12)),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (widget.hino.isDownloaded)
                  IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                    onPressed: () async {
                      await downloadService.deleteDownload(widget.hino);
                      setState(() {});
                    },
                  )
                else
                  IconButton(
                    icon: const Icon(Icons.download_for_offline_outlined),
                    color: Theme.of(context).primaryColor,
                    onPressed: _isDownloading ? null : () async {
                      setState(() => _isDownloading = true);
                      try {
                        await downloadService.downloadAudio(widget.hino, (progress) {
                          setState(() => _downloadProgress = progress);
                        });
                        setState(() {});
                      } catch (e) {
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Erro no download: $e')),
                          );
                        }
                      } finally {
                        if (mounted) setState(() => _isDownloading = false);
                      }
                    },
                  ),
                StreamBuilder<PlayerState>(
                  stream: audioService.player.playerStateStream,
                  builder: (context, snapshot) {
                    final playerState = snapshot.data;
                    final processingState = playerState?.processingState;
                    final playing = playerState?.playing;
                    
                    if (processingState == ProcessingState.loading ||
                        processingState == ProcessingState.buffering) {
                      return const SizedBox(
                        height: 48,
                        width: 48,
                        child: CircularProgressIndicator(),
                      );
                    } else if (playing != true) {
                      return IconButton(
                        icon: const Icon(Icons.play_circle_fill, size: 64),
                        color: Theme.of(context).primaryColor,
                        onPressed: () => audioService.playHino(widget.hino),
                      );
                    } else {
                      return IconButton(
                        icon: const Icon(Icons.pause_circle_filled, size: 64),
                        color: Theme.of(context).primaryColor,
                        onPressed: audioService.pause,
                      );
                    }
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.stop_circle_outlined),
                  onPressed: () => audioService.stop(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }
}
