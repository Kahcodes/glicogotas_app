import 'package:shared_preferences/shared_preferences.dart';

class PreferencesStore {
  PreferencesStore({Future<SharedPreferences>? preferences})
      : _preferences = preferences ?? SharedPreferences.getInstance();

  final Future<SharedPreferences> _preferences;

  Future<bool> getBool(String key, {required bool fallback}) async {
    final prefs = await _preferences;
    return prefs.getBool(key) ?? fallback;
  }

  Future<void> setBool(String key, bool value) async {
    final prefs = await _preferences;
    await prefs.setBool(key, value);
  }

  Future<double> getDouble(String key, {required double fallback}) async {
    final prefs = await _preferences;
    return prefs.getDouble(key) ?? fallback;
  }

  Future<void> setDouble(String key, double value) async {
    final prefs = await _preferences;
    await prefs.setDouble(key, value);
  }

  Future<int> getInt(String key, {required int fallback}) async {
    final prefs = await _preferences;
    return prefs.getInt(key) ?? fallback;
  }

  Future<void> setInt(String key, int value) async {
    final prefs = await _preferences;
    await prefs.setInt(key, value);
  }
}
