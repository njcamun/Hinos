import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  static const String _fontSizeKey = 'font_size';
  final SharedPreferences _prefs;

  SettingsService(this._prefs);

  double get fontSize => _prefs.getDouble(_fontSizeKey) ?? 18.0;

  Future<void> setFontSize(double size) async {
    await _prefs.setDouble(_fontSizeKey, size);
  }
}
