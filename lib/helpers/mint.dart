import 'dart:async';
import 'dart:math';

class Mint {
  static Random _random = Random();
  static StreamController<String> _controller =
      StreamController<String>.broadcast();

  static Stream<String> get coinProduction => _controller.stream;

  /// A method that starts a timer to produce coins.
  ///
  /// Call this method once when the app runs.
  static void initialize() {
    Timer.periodic(
      Duration(seconds: 2),
      (timer) => generateCoin(),
    );
  }

  static void generateCoin() {
    bool isAuthentic = _random.nextBool();
    if (isAuthentic) {
      _controller.add('Real');
    } else {
      _controller.add('Fake');
    }
  }
}
