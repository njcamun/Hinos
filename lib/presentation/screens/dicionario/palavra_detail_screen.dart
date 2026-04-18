import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/dicionario_model.dart';
import '../../providers/providers.dart';
import '../hinos/hino_detail_screen.dart';

class PalavraDetailScreen extends ConsumerWidget {
  final PalavraDicionario palavra;
  const PalavraDetailScreen({super.key, required this.palavra});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhe do Termo'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(26, 35, 126, 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF1A237E), width: 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    palavra.palavra,
                    style: const TextStyle(
                      fontSize: 28,
                      fontFamily: 'Serif',
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A237E),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Língua: ${palavra.idioma}',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Sans-serif',
                      color: Colors.grey[700],
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Significado / Explicação:',
              style: TextStyle(fontSize: 18, fontFamily: 'Serif', fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              palavra.explicacao ?? 'Sem explicação disponível.',
              style: const TextStyle(fontSize: 18, fontFamily: 'Sans-serif', height: 1.4),
            ),
            const SizedBox(height: 24),
            if (palavra.exemploUso != null) ...[
              const Text(
                'Exemplo de Uso:',
                style: TextStyle(fontSize: 18, fontFamily: 'Serif', fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(255, 215, 0, 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  palavra.exemploUso!,
                  style: const TextStyle(fontSize: 16, fontFamily: 'Sans-serif', fontStyle: FontStyle.italic),
                ),
              ),
            ],
            const SizedBox(height: 32),
            if (palavra.hinoIdRelacionado != null)
              Center(
                child: ElevatedButton.icon(
                  onPressed: () async {
                    final hinos = await ref.read(hinosRepositoryProvider).getAllHinos();
                    final hino = hinos.firstWhere(
                      (h) => h.numero == palavra.hinoIdRelacionado,
                      orElse: () => throw Exception('Hino não encontrado'),
                    );
                    if (context.mounted) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HinoDetailScreen(hino: hino),
                        ),
                      );
                    }
                  },
                  icon: const Icon(Icons.music_note),
                  label: const Text('Ver Hino Relacionado'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1A237E),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
