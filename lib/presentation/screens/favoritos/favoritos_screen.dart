import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/providers.dart';
import '../hinos/hino_detail_screen.dart';

class FavoritosScreen extends ConsumerWidget {
  const FavoritosScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritosAsync = ref.watch(favoritosProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Favoritos'),
      ),
      body: favoritosAsync.when(
        data: (hinos) {
          if (hinos.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.star_border, size: 80, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'Você ainda não tem hinos favoritos.',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                ],
              ),
            );
          }
          return ListView.builder(
            itemCount: hinos.length,
            itemBuilder: (context, index) {
              final hino = hinos[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,
                  child: Text(
                    '${hino.numero}',
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
                title: Text(hino.titulo),
                subtitle: Text(hino.autor ?? 'Desconhecido'),
                trailing: const Icon(Icons.star, color: Colors.amber),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HinoDetailScreen(hino: hino),
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Erro: $err')),
      ),
    );
  }
}
