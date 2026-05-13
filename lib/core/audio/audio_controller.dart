import 'package:flutter/widgets.dart';
import 'package:glicogotas_app/core/audio/audio_player_service.dart';
import 'package:glicogotas_app/features/settings/data/settings_repository.dart';

class AudioController {
  AudioController({
    required SettingsRepository settings,
    AudioPlayerService? service,
  })  : _settings = settings,
        _service = service ?? AudioPlayerService();

  final SettingsRepository _settings;
  final AudioPlayerService _service;

  String? _currentAsset;
  bool _disposed = false;

  Future<void> play(String assetPath) async {
    if (_disposed) return;
    _currentAsset = assetPath;
    if (_settings.musicOn) {
      await _service.playAsset(assetPath, volume: _settings.volume);
    } else {
      await _service.stop();
    }
  }

  Future<void> resume() async {
    final asset = _currentAsset;
    if (_disposed || asset == null || !_settings.musicOn) return;
    await _service.playAsset(asset, volume: _settings.volume);
  }

  Future<void> syncWithSettings() async {
    if (_disposed) return;
    if (_settings.musicOn) {
      await _service.setVolume(_settings.volume);
      await resume();
    } else {
      await stop();
    }
  }

  Future<void> stop() => _service.stop();

  Future<void> dispose() async {
    _disposed = true;
    await _service.dispose();
  }
}

mixin PageAudioMixin<T extends StatefulWidget> on State<T> {
  AudioController? _audioController;
  SettingsRepository? _settings;
  VoidCallback? _settingsListener;
  bool _pageAudioInitialized = false;

  AudioController get audioController => _audioController!;

  void initPageAudio(SettingsRepository settings, String assetPath) {
    if (_pageAudioInitialized) return;
    _pageAudioInitialized = true;
    _settings = settings;
    _audioController = AudioController(settings: settings);
    _settingsListener = () => _audioController?.syncWithSettings();
    settings.addListener(_settingsListener!);
    _audioController!.play(assetPath);
  }

  void disposePageAudio() {
    final listener = _settingsListener;
    final settings = _settings;
    if (listener != null && settings != null) {
      settings.removeListener(listener);
    }
    _audioController?.dispose();
  }
}
