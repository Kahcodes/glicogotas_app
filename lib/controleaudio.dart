import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:glicogotas_app/shared/repositories/configuracoes_repository.dart';

class AudioManager {
  static final Set<AudioManager> _activeManagers = <AudioManager>{};

  final AudioPlayer _audioPlayer = AudioPlayer();
  String? _currentAssetPath;
  double _currentVolume = 0.7;

  AudioManager() {
    _activeManagers.add(this);
  }

  static Future<void> stopAll() async {
    await Future.wait(
      _activeManagers.map((manager) => manager.stop()),
      eagerError: false,
    );
  }

  Future<void> setVolume(double volume) async {
    _currentVolume = volume.clamp(0.1, 1.0);
    await _audioPlayer.setVolume(_currentVolume);
  }

  Future<void> play(String assetPath, BuildContext context) async {
    final configuracoesProvider =
        Provider.of<ConfiguracoesRepository>(context, listen: false);

    _currentAssetPath = assetPath; // Armazena o caminho atual

    if (configuracoesProvider.musicOn) {
      try {
        await setVolume(configuracoesProvider.volume);
        await _audioPlayer.stop();
        await _audioPlayer.play(
          AssetSource(assetPath),
          volume: _currentVolume,
          mode: PlayerMode.mediaPlayer,
        );
      } catch (error, stackTrace) {
        if (kDebugMode) {
          debugPrint('Erro ao tocar audio $assetPath: $error');
          debugPrintStack(stackTrace: stackTrace);
        }
      }
    } else {
      await _audioPlayer.stop();
    }
  }

  Future<void> resume(BuildContext context) async {
    final configuracoesProvider =
        Provider.of<ConfiguracoesRepository>(context, listen: false);

    if (configuracoesProvider.musicOn && _currentAssetPath != null) {
      await play(_currentAssetPath!, context);
    }
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
  }

  bool get isPlaying => _audioPlayer.state == PlayerState.playing;

  void dispose() {
    _activeManagers.remove(this);
    _audioPlayer.dispose();
  }
}
