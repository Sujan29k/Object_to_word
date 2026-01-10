import 'package:audioplayers/audioplayers.dart';

class AudioService {
  static final AudioService _instance = AudioService._internal();
  factory AudioService() => _instance;
  AudioService._internal();

  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isMuted = false;

  bool get isMuted => _isMuted;

  void toggleMute() {
    _isMuted = !_isMuted;
  }

  Future<void> playTap() async {
    if (_isMuted) return;
    try {
      await _audioPlayer.stop();
      await _audioPlayer.play(AssetSource('audio/tap.wav'));
    } catch (e) {
      print('Error playing tap sound: $e');
    }
  }

  Future<void> playCorrect() async {
    if (_isMuted) return;
    try {
      await _audioPlayer.stop();
      await _audioPlayer.play(AssetSource('audio/correct.wav'));
    } catch (e) {
      print('Error playing correct sound: $e');
    }
  }

  Future<void> playWrong() async {
    if (_isMuted) return;
    try {
      await _audioPlayer.stop();
      await _audioPlayer.play(AssetSource('audio/wrong.wav'));
    } catch (e) {
      print('Error playing wrong sound: $e');
    }
  }

  void dispose() {
    _audioPlayer.dispose();
  }
}
