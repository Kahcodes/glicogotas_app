import 'package:flutter/foundation.dart';
import 'package:glicogotas_app/core/persistence/preferences_store.dart';

class SettingsRepository extends ChangeNotifier {
  SettingsRepository(this._store) : _loadFuture = Future.value() {
    _loadFuture = _loadPreferences();
  }

  static const _soundOnKey = 'soundOn';
  static const _musicOnKey = 'musicOn';
  static const _volumeKey = 'volume';

  final PreferencesStore _store;
  late Future<void> _loadFuture;

  bool _soundOn = true;
  bool _musicOn = true;
  double _volume = 0.7;

  bool get soundOn => _soundOn;
  bool get musicOn => _musicOn;
  double get volume => _volume;

  Future<void> load() => _loadFuture;

  Future<void> _loadPreferences() async {
    _soundOn = await _store.getBool(_soundOnKey, fallback: true);
    _musicOn = await _store.getBool(_musicOnKey, fallback: true);
    _volume = await _store.getDouble(_volumeKey, fallback: 0.7);
    notifyListeners();
  }

  Future<void> switchSoundOn() async {
    await _loadFuture;
    _soundOn = !_soundOn;
    await _store.setBool(_soundOnKey, _soundOn);
    notifyListeners();
  }

  Future<void> switchMusicOn() async {
    await _loadFuture;
    _musicOn = !_musicOn;
    await _store.setBool(_musicOnKey, _musicOn);
    notifyListeners();
  }

  Future<void> setVolume(double value) async {
    await _loadFuture;
    _volume = value;
    await _store.setDouble(_volumeKey, value);
    notifyListeners();
  }
}
