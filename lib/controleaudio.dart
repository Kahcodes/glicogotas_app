import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:glicogotas_app/shared/repositories/configuracoes_repository.dart';

class AudioManager {
  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> play(String assetPath, BuildContext context) async {
    final configuracoesProvider =
        Provider.of<ConfiguracoesRepository>(context, listen: false);

    if (configuracoesProvider.soundOn) {
      await _audioPlayer.play(AssetSource(assetPath));
    } else {
      await _audioPlayer.stop();
    }
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
  }

  void dispose() {
    _audioPlayer.dispose();
  }
}
