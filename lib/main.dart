import 'package:coin_detector/coin-detector-app.dart';
import 'package:coin_detector/helpers/mint.dart';
import 'package:flutter/material.dart';

void main() {
  Mint.initialize();

  runApp(CoinDetectorApp());
}
