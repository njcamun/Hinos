import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/services/database_service.dart';
import 'presentation/providers/providers.dart';
import 'presentation/providers/settings_provider.dart';
import 'presentation/screens/main_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa o Just Audio Background apenas se NÃO for Web
  if (!kIsWeb) {
    await JustAudioBackground.init(
      androidNotificationChannelId: 'com.nelson.harpa_crista_angolana.channel.audio',
      androidNotificationChannelName: 'Reprodução de Áudio',
      androidNotificationOngoing: true,
    );
  }

  // Inicializa o SharedPreferences
  final sharedPrefs = await SharedPreferences.getInstance();

  // Inicializa o banco de dados Drift
  final dbService = DatabaseService();
  await dbService.init();

  runApp(
    ProviderScope(
      overrides: [
        databaseProvider.overrideWithValue(dbService.database),
        sharedPreferencesProvider.overrideWithValue(sharedPrefs),
      ],
      child: const HarpaApp(),
    ),
  );
}

class HarpaApp extends StatelessWidget {
  const HarpaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Harpa Cristã Angolana',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1B5E20), // Verde Escuro
          primary: const Color(0xFF1B5E20),
          secondary: const Color(0xFFFFD700), // Gold
          surface: Colors.white,
        ),
        scaffoldBackgroundColor: Colors.white,
        cardTheme: CardThemeData(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          color: Colors.white,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1B5E20), // Verde na barra de título
          foregroundColor: Colors.white,
          centerTitle: true,
          elevation: 4,
          titleTextStyle: TextStyle(
            fontFamily: 'Serif',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(fontFamily: 'Serif', fontWeight: FontWeight.bold),
          bodyMedium: TextStyle(fontFamily: 'Sans-serif'),
        ),
      ),
      home: const MainScreen(),
    );
  }
}
