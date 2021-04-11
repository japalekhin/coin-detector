import 'package:coint_detector/routes/home.dart';
import 'package:flutter/material.dart';

class CoinDetectorApp extends StatefulWidget {
  @override
  CoinDetectorAppState createState() => CoinDetectorAppState();
}

class CoinDetectorAppState extends State<CoinDetectorApp> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        String appTitle = 'Mint';
        if (snapshot.hasData) {
          appTitle = snapshot.data ?? 'Mint';
        }
        return MaterialApp(
          title: appTitle,
          home: HomePage(),
        );
      },
    );
  }
}
