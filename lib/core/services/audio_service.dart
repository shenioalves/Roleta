import 'package:audioplayers/audioplayers.dart';

class AudioService {
  final AudioPlayer _spinPlayer = AudioPlayer();
  final AudioPlayer _dingPlayer = AudioPlayer();

  Future<void> init() async {
    await _spinPlayer.setSource(AssetSource('sounds/spin.mp3'));
    await _dingPlayer.setSource(AssetSource('sounds/ding.mp3'));
  }

  Future<void> playSpinSound() async {
    await _spinPlayer.seek(Duration.zero);
    await _spinPlayer.resume();
  }

  Future<void> playResultSound() async {
    await _spinPlayer.stop();
    await _dingPlayer.seek(Duration.zero);
    await _dingPlayer.resume();
  }

  void dispose() {
    _spinPlayer.dispose();
    _dingPlayer.dispose();
  }
}
