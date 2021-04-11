import 'dart:async';
import 'dart:math';

class Mint {
  static Random _random = Random();
  static StreamController<String> _controller = StreamController<String>();

  static Stream<String> get coinProduction => _controller.stream;

  static void initialize() {
    Timer.periodic(
      Duration(seconds: 2),
      (timer) => generateCoin(),
    );
  }

  static void generateCoin() {
    bool isAuthentic = _random.nextBool();
    if (isAuthentic) {
      _controller.add('REAL');
    } else {
      _controller.add('FAKE');
    }
  }
}
