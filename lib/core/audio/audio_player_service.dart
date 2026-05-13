import 'package:audioplayers/audioplayers.dart';

class AudioPlayerService {
  final AudioPlayer _player = AudioPlayer();

  Future<void> playAsset(String assetPath, {double volume = 0.7}) async {
    await _player.setVolume(volume);
    await _player.play(AssetSource(assetPath));
  }

  Future<void> stop() => _player.stop();

  Future<void> setVolume(double volume) => _player.setVolume(volume);

  bool get isPlaying => _player.state == PlayerState.playing;

  Future<void> dispose() => _player.dispose();
}
