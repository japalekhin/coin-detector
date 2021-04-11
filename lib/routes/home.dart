import 'package:coint_detector/classes/coin.dart';
import 'package:coint_detector/helpers/mint.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final List<Coin> coins = [];
  String appTitle = 'Mint';

  @override
  void initState() {
    Mint.coinProduction.listen(onCoinGenerate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appTitle),
      ),
      body: AnimatedList(
        key: _listKey,
        itemBuilder: (
          BuildContext context,
          int index,
          Animation<double> animation,
        ) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween(
                begin: Offset(0.2, 0),
                end: Offset(0.0, 0),
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Curves.linearToEaseOut,
                ),
              ),
              child: ListTile(
                title: Text(coins[index].value),
                subtitle: Text(coins[index].produced.toIso8601String()),
              ),
            ),
          );
        },
      ),
    );
  }

  void onCoinGenerate(String data) {
    Coin coin = Coin(
      value: data,
      produced: DateTime.now(),
    );
    coins.insert(0, coin);

    setState(() => appTitle = data);

    _listKey.currentState!.insertItem(0, duration: Duration(milliseconds: 350));

    if (!kReleaseMode) {
      print('Got a coin that is: ' + data);
    }
  }
}
