import 'package:coint_detector/coin-detector-app.dart';
import 'package:coint_detector/helpers/mint.dart';
import 'package:flutter/material.dart';

void main() {
  Mint.initialize();

  runApp(CoinDetectorApp());
}
