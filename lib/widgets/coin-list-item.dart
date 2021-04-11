import 'package:coint_detector/classes/coin.dart';
import 'package:flutter/material.dart';

class CoinListItem extends StatefulWidget {
  final Coin coin;

  const CoinListItem({
    Key? key,
    required this.coin,
  }) : super(key: key);

  @override
  CoinListItemState createState() => CoinListItemState();
}

class CoinListItemState extends State<CoinListItem>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    duration: const Duration(milliseconds: 500),
    vsync: this,
  );

  late final Animation<Offset> _slideAnimation = Tween(
    begin: Offset(.75, 0),
    end: Offset.zero,
  ).animate(CurvedAnimation(
    parent: _animationController,
    curve: Curves.linearToEaseOut,
  ));

  bool isExpanded = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    _animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    List<Widget> children = [];
    children.add(Text(widget.coin.value));
    if (isExpanded) {
      children.add(SizedBox(height: 8));
      children.add(Text(widget.coin.produced.toIso8601String()));
    }

    return FadeTransition(
      opacity: _animationController,
      child: SlideTransition(
        position: _slideAnimation,
        child: Container(
          child: InkWell(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                children: children,
              ),
            ),
            onTap: onTap,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void onTap() {
    setState(() => isExpanded = !isExpanded);
  }
}
