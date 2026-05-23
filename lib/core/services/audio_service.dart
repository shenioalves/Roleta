import 'package:audioplayers/audioplayers.dart';

class AudioService {
  final AudioPlayer _spinPlayer = AudioPlayer();
  final AudioPlayer _dingPlayer = AudioPlayer();

  Future<void> init() async {
    await _spinPlayer.setPlayerMode(PlayerMode.lowLatency);
    await _dingPlayer.setPlayerMode(PlayerMode.lowLatency);

    await _spinPlayer.setReleaseMode(ReleaseMode.stop);
    await _dingPlayer.setReleaseMode(ReleaseMode.stop);
  }

  Future<void> playSpinSound() async {
    await _spinPlayer.stop();
    await _spinPlayer.play(AssetSource('sounds/spin.mp3'));
  }

  Future<void> playResultSound() async {
    await _spinPlayer.stop();
    await _dingPlayer.stop();
    await _dingPlayer.play(AssetSource('sounds/ding.mp3'));
  }

  void dispose() {
    _spinPlayer.dispose();
    _dingPlayer.dispose();
  }
}
