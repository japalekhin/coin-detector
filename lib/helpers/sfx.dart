import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

class Sfx {
  static final AudioCache _coinPlayer = AudioCache(
    fixedPlayer: AudioPlayer(
      mode: PlayerMode.LOW_LATENCY,
    ),
  );

  static void playRealCoin() async {
    _coinPlayer.play(
      'audio/sfx/score-clay-coin.mp3',
      volume: .75,
    );
  }
}
