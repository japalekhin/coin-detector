import 'dart:async';
import 'dart:math';

class Mint {
  static Random _random = Random();
  static List<String> _coins = [];
  static StreamController<List<String>> _controller =
      StreamController<List<String>>.broadcast();

  static Stream<List<String>> get coinProduction => _controller.stream;

  static void initialize() {
    Timer.periodic(
      Duration(seconds: 2),
      (timer) => generateCoin(),
    );
  }

  static void generateCoin() {
    bool isAuthentic = _random.nextBool();

    if (isAuthentic) {
      _coins.add('REAL');
    } else {
      _coins.add('FAKE');
    }

    _controller.add(_coins);
  }
}
