import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfiguracoesRepository extends ChangeNotifier {
  bool _soundOn = true;
  bool get soundOn => _soundOn;

  Future<bool> getSoundOn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('soundOn') ?? true;
  }

  switchSoundOn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('soundOn', !await getSoundOn());
    _soundOn = await getSoundOn();
    notifyListeners();
  }
}
