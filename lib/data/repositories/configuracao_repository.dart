// lib/data/repositories/configuracao_repository.dart
// REMOVA ESTE IMPORT: import 'package:harpa_crista_angolana/core/database/app_database.dart';
import 'package:harpa_crista_angolana/core/models/configuracao_model.dart'; // Mantenha este import
import 'package:shared_preferences/shared_preferences.dart'; // NOVO: Importa SharedPreferences

class ConfiguracaoRepository {
  // Chaves para SharedPreferences
  static const _keyIsDarkMode = 'isDarkMode';
  static const _keyFontSizeFactor = 'fontSizeFactor';

  // Método para obter as configurações (agora de SharedPreferences)
  Future<Configuracao> getConfiguracoes() async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkMode = prefs.getBool(_keyIsDarkMode) ?? false;
    final fontSizeFactor = prefs.getDouble(_keyFontSizeFactor) ?? 1.0;

    return Configuracao(isDarkMode: isDarkMode, fontSizeFactor: fontSizeFactor);
  }

  // Método para salvar as configurações (agora em SharedPreferences)
  Future<void> saveConfiguracoes(Configuracao configuracao) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyIsDarkMode, configuracao.isDarkMode);
    await prefs.setDouble(_keyFontSizeFactor, configuracao.fontSizeFactor);
  }
}