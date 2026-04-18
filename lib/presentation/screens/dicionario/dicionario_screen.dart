import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/providers.dart';
import 'palavra_detail_screen.dart';

class DicionarioScreen extends ConsumerStatefulWidget {
  const DicionarioScreen({super.key});

  @override
  ConsumerState<DicionarioScreen> createState() => _DicionarioScreenState();
}

class _DicionarioScreenState extends ConsumerState<DicionarioScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final palavrasAsync = ref.watch(searchDictionaryProvider(_query));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dicionário de Línguas'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Pesquisar palavra ou significado...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                suffixIcon: _query.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
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
          Expanded(
            child: palavrasAsync.when(
              data: (palavras) {
                if (palavras.isEmpty) {
                  return const Center(child: Text('Nenhuma palavra encontrada.'));
                }
                return ListView.separated(
                  itemCount: palavras.length,
                  separatorBuilder: (context, index) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final p = palavras[index];
                    return ListTile(
                      title: Text(
                        p.palavra,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('${p.idioma} - ${p.explicacao ?? ""}'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PalavraDetailScreen(palavra: p),
                        ),
                      ),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Erro: $err')),
            ),
          ),
        ],
      ),
    );
  }
}
