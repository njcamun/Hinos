import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/providers.dart';
import '../../../data/models/hino_model.dart';
import 'hino_detail_screen.dart';
import '../dicionario/palavra_detail_screen.dart';

class HinosListScreen extends ConsumerStatefulWidget {
  final bool isDictionaryMode;
  const HinosListScreen({super.key, this.isDictionaryMode = false});

  @override
  ConsumerState<HinosListScreen> createState() => _HinosListScreenState();
}

class _HinosListScreenState extends ConsumerState<HinosListScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';
  int _selectedHarpaSubTab = 0; // 0 for Hinos, 1 for Favoritos

  @override
  Widget build(BuildContext context) {
    final hinosAsync = ref.watch(filteredHinosProvider(_query));
    final favoritosAsync = ref.watch(favoritosProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      appBar: AppBar(
        title: Text(
          widget.isDictionaryMode ? 'Dicionário de línguas nacionais' : 'Hinário Digital',
          style: const TextStyle(fontFamily: 'Serif', fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline, size: 22),
            onPressed: () => _showAboutDialog(context),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar (Shared)
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromRGBO(255, 255, 255, 0.8),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromRGBO(0, 0, 0, 0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                style: const TextStyle(fontFamily: 'Sans-serif'),
                decoration: InputDecoration(
                  hintText: widget.isDictionaryMode 
                      ? 'Pesquise no dicionário...' 
                      : 'Pesquise por número ou título...',
                  hintStyle: TextStyle(color: Colors.grey[400], fontSize: 15),
                  prefixIcon: const Icon(Icons.search, color: Color(0xFF546E7A), size: 20),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 15),
                  suffixIcon: _query.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear, size: 18),
                          onPressed: () {
                            _searchController.clear();
                            setState(() => _query = '');
                          },
                        )
                      : null,
                ),
                onChanged: (value) => setState(() => _query = value),
              ),
            ),
          ),

          // Contextual Top Navigation: Hinos vs Favoritos (Only in Harpa Mode)
          if (!widget.isDictionaryMode)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: SizedBox(
                width: double.infinity,
                child: SegmentedButton<int>(
                  segments: const [
                    ButtonSegment(
                      value: 0,
                      label: const Text('Hinos'),
                      icon: const Icon(Icons.format_list_bulleted),
                    ),
                    ButtonSegment(
                      value: 1,
                      label: const Text('Favoritos'),
                      icon: const Icon(Icons.favorite_outline),
                    ),
                  ],
                  selected: {_selectedHarpaSubTab},
                  onSelectionChanged: (Set<int> newSelection) {
                    setState(() {
                      _selectedHarpaSubTab = newSelection.first;
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.resolveWith<Color?>(
                      (states) {
                        if (states.contains(WidgetState.selected)) {
                          return const Color(0xFF1A237E);
                        }
                        return Colors.white;
                      },
                    ),
                    foregroundColor: WidgetStateProperty.resolveWith<Color?>(
                      (states) {
                        if (states.contains(WidgetState.selected)) {
                          return Colors.white;
                        }
                        return const Color(0xFF1A237E);
                      },
                    ),
                    side: WidgetStateProperty.all(
                      const BorderSide(color: Color(0xFF1A237E), width: 0.5),
                    ),
                  ),
                ),
              ),
            ),

          // Body Content
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: widget.isDictionaryMode
                  ? DicionarioScreenContent(query: _query)
                  : (_selectedHarpaSubTab == 0 
                      ? _buildHinosList(hinosAsync)
                      : _buildHinosList(favoritosAsync)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHinosList(AsyncValue<List<Hino>> hinosAsync) {
    return hinosAsync.when(
      data: (hinos) {
        // Local filtering for favorites if search is applied
        final listToShow = _selectedHarpaSubTab == 1 && _query.isNotEmpty
            ? hinos.where((h) => h.titulo.toLowerCase().contains(_query.toLowerCase()) || h.numero.toString() == _query).toList()
            : hinos;

        if (listToShow.isEmpty) {
          return Center(
            child: Text(
              _selectedHarpaSubTab == 1 ? 'Nenhum favorito encontrado.' : 'Nenhum hino encontrado.',
              style: const TextStyle(fontFamily: 'Sans-serif', color: Colors.grey),
            ),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          itemCount: listToShow.length,
          itemBuilder: (context, index) {
            final hino = listToShow[index];
            final lyricsPreview = hino.letra.split('\n').first.trim();

            return Container(
              key: ValueKey(hino.id),
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  const BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.04),
                    blurRadius: 12,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        width: 5,
                        color: _selectedHarpaSubTab == 1 ? const Color(0xFFFFD700) : const Color(0xFF1A237E),
                      ),
                      Expanded(
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          leading: Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: _selectedHarpaSubTab == 1 ? const Color.fromRGBO(255, 215, 0, 0.1) : const Color.fromRGBO(26, 35, 126, 0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                hino.numero.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: _selectedHarpaSubTab == 1 ? const Color(0xFFB8860B) : const Color(0xFF1A237E),
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          title: Text(
                            hino.titulo,
                            style: const TextStyle(
                              fontFamily: 'Serif',
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Color(0xFF1A237E),
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 4),
                              Text(
                                lyricsPreview,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: 'Sans-serif',
                                  color: Colors.blueGrey[600],
                                  fontSize: 13,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                          trailing: GestureDetector(
                            onTap: () => ref.read(hinosRepositoryProvider).toggleFavorito(hino),
                            child: Icon(
                              hino.isFavorito ? Icons.favorite : Icons.favorite_border,
                              color: hino.isFavorito ? Colors.redAccent : Colors.grey[400],
                              size: 24,
                            ),
                          ),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HinoDetailScreen(hino: hino)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator(strokeWidth: 2)),
      error: (err, stack) => Center(child: Text('Erro: $err')),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'Hinário Digital',
      applicationVersion: '1.0.0',
      applicationIcon: const Icon(Icons.library_music_rounded, size: 50, color: Color(0xFF1A237E)),
      children: const [
        Text(
          'Desenvolvido para a preservação e louvor através do hinário popular angolano.\n\n'
          'Créditos: Nelson Jessé\n'
          'Design Sophisticated & Modern.',
          style: TextStyle(fontFamily: 'Sans-serif'),
        ),
      ],
    );
  }
}

class DicionarioScreenContent extends ConsumerWidget {
  final String query;
  const DicionarioScreenContent({super.key, this.query = ''});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palavrasAsync = query.isEmpty 
        ? ref.watch(dictionaryListProvider)
        : ref.watch(searchDictionaryProvider(query));

    return palavrasAsync.when(
      data: (palavras) {
        if (palavras.isEmpty) {
          return const Center(child: Text('Nenhuma palavra encontrada.'));
        }
        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          itemCount: palavras.length,
          itemBuilder: (context, index) {
            final p = palavras[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  const BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.04),
                    blurRadius: 12,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      Container(width: 5, color: const Color(0xFF8B0000)),
                      Expanded(
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          title: Text(p.palavra, 
                            style: const TextStyle(fontFamily: 'Serif', fontWeight: FontWeight.bold, color: Color(0xFF1A237E))),
                          subtitle: Text('${p.idioma} - ${p.explicacao ?? ""}',
                            style: const TextStyle(fontFamily: 'Sans-serif', fontSize: 13, height: 1.3)),
                          trailing: Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey[400]),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => PalavraDetailScreen(palavra: p)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator(strokeWidth: 2)),
      error: (err, stack) => Center(child: Text('Erro: $err')),
    );
  }
}
