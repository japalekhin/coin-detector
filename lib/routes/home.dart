import 'package:coint_detector/classes/coin.dart';
import 'package:coint_detector/helpers/mint.dart';
import 'package:coint_detector/helpers/sfx.dart';
import 'package:coint_detector/widgets/coin-list-item.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final List<Coin> coins = [];
  String appTitle = 'Mint';

  @override
  void initState() {
    Mint.coinProduction.listen(onCoinReceived);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    for (int i = 0; i < coins.length; i++) {
      if (i > 0) {
        children.add(Divider());
      }
      children.add(CoinListItem(
        key: ObjectKey(coins[i]),
        coin: coins[i],
      ));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(appTitle),
      ),
      body: ListView(
        children: children,
      ),
    );
  }

  void onCoinReceived(String data) {
    if (data == 'Real') {
      Sfx.playRealCoin();
    }

    final Coin coin = Coin(
      value: data,
      produced: DateTime.now(),
    );

    setState(() {
      appTitle = data;
      coins.insert(0, coin);
    });

    if (!kReleaseMode) {
      print('Got a coin that is: ' + data);
    }
  }
}
