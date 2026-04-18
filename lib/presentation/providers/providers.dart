import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/database/app_database.dart';
import '../../core/services/audio_service.dart';
import '../../core/services/download_service.dart';
import '../../data/repositories/hinos_repository.dart';
import '../../data/repositories/dictionary_repository.dart';
import '../../data/models/hino_model.dart';
import '../../data/models/dicionario_model.dart';

// Database Provider
final databaseProvider = Provider<AppDatabase>((ref) {
  throw UnimplementedError();
});

// Repositories
final hinosRepositoryProvider = Provider<HinosRepository>((ref) {
  final database = ref.watch(databaseProvider);
  return HinosRepository(database);
});

final dictionaryRepositoryProvider = Provider<DictionaryRepository>((ref) {
  final database = ref.watch(databaseProvider);
  return DictionaryRepository(database);
});

// Services
final audioServiceProvider = Provider<AudioService>((ref) {
  final service = AudioService();
  ref.onDispose(() => service.dispose());
  return service;
});

final downloadServiceProvider = Provider<DownloadService>((ref) {
  final repository = ref.watch(hinosRepositoryProvider);
  return DownloadService(repository);
});

// Data Providers (Reativos com Streams)
final hinosStreamProvider = StreamProvider<List<Hino>>((ref) {
  final repository = ref.watch(hinosRepositoryProvider);
  return repository.watchHinos();
});

final filteredHinosProvider = Provider.family<AsyncValue<List<Hino>>, String>((ref, query) {
  final hinosAsync = ref.watch(hinosStreamProvider);
  
  return hinosAsync.whenData((hinos) {
    if (query.isEmpty) return hinos;
    
    final int? numQuery = int.tryParse(query);
    return hinos.where((h) {
      return h.numero == numQuery || 
             h.titulo.toLowerCase().contains(query.toLowerCase()) ||
             h.letra.toLowerCase().contains(query.toLowerCase());
    }).toList();
  });
});

final dictionaryListProvider = FutureProvider<List<PalavraDicionario>>((ref) async {
  final repository = ref.watch(dictionaryRepositoryProvider);
  return repository.getAllPalavras();
});

final searchDictionaryProvider = FutureProvider.family<List<PalavraDicionario>, String>((ref, query) async {
  final repository = ref.watch(dictionaryRepositoryProvider);
  return repository.searchPalavras(query);
});

final favoritosProvider = Provider<AsyncValue<List<Hino>>>((ref) {
  final hinosAsync = ref.watch(hinosStreamProvider);
  return hinosAsync.whenData((hinos) => hinos.where((h) => h.isFavorito).toList());
});
