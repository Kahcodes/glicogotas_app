import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfiguracoesRepository extends ChangeNotifier {
  bool _soundOn = true;
  bool _musicOn = true;
  double _volume = 0.7;
  String _language = 'Português';

  bool get soundOn => _soundOn;
  bool get musicOn => _musicOn;
  double get volume => _volume;
  String get language => _language;

  // Obter estado do som
  Future<bool> getSoundOn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('soundOn') ?? true;
  }

  // Alterar estado do som
  Future<void> switchSoundOn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _soundOn = !await getSoundOn();
    await prefs.setBool('soundOn', _soundOn);
    notifyListeners();
  }

  // Obter estado da música
  Future<bool> getMusicOn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('musicOn') ?? true;
  }

  // Alterar estado da música
  Future<void> switchMusicOn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _musicOn = !await getMusicOn();
    await prefs.setBool('musicOn', _musicOn);
    notifyListeners();
  }

  // Obter volume
  Future<double> getVolume() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble('volume') ?? 0.7;
  }

  // Alterar volume
  Future<void> setVolume(double value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _volume = value;
    await prefs.setDouble('volume', value);
    notifyListeners();
  }

  // Obter idioma
  Future<String> getLanguage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('language') ?? 'Português';
  }

  // Alterar idioma
  Future<void> setLanguage(String lang) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _language = lang;
    await prefs.setString('language', lang);
    notifyListeners();
  }
}
