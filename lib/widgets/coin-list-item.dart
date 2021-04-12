import 'package:coint_detector/classes/coin.dart';
import 'package:flutter/material.dart';

class CoinListItem extends StatefulWidget {
  final Duration appearanceAnimationDuration = const Duration(
    milliseconds: 500,
  );
  final Duration expanderAnimationDuration = const Duration(
    milliseconds: 250,
  );
  final Coin coin;

  const CoinListItem({
    Key? key,
    required this.coin,
  }) : super(key: key);

  @override
  CoinListItemState createState() => CoinListItemState();
}

class CoinListItemState extends State<CoinListItem>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  late final AnimationController _expanderAnimationController =
      AnimationController(
    duration: widget.expanderAnimationDuration,
    vsync: this,
  );

  late final AnimationController _appearanceAnimationController =
      AnimationController(
    duration: widget.appearanceAnimationDuration,
    vsync: this,
  );
  late final Animation<Offset> _slideAnimation = Tween(
    begin: Offset(.75, 0),
    end: Offset.zero,
  ).animate(CurvedAnimation(
    parent: _appearanceAnimationController,
    curve: Curves.linearToEaseOut,
  ));

  bool isExpanded = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    _appearanceAnimationController.forward();
    _expanderAnimationController.addListener(onExpanderAnimation);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    List<Widget> children = [];
    children.add(
      Text(
        widget.coin.value,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
    if (isExpanded) {
      children.add(
        SizeTransition(
          sizeFactor: _expanderAnimationController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 12),
              Center(
                child: Text(
                  widget.coin.produced.toIso8601String(),
                  style: TextStyle(
                    color: Color(0xff888888),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return FadeTransition(
      opacity: _appearanceAnimationController,
      child: SlideTransition(
        position: _slideAnimation,
        child: Container(
          child: InkWell(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
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
    _appearanceAnimationController.dispose();
    _expanderAnimationController.dispose();
    super.dispose();
  }

  void onTap() {
    if (isExpanded) {
      _expanderAnimationController.reverse();
    } else {
      setState(() => isExpanded = true);
      _expanderAnimationController.forward();
    }
  }

  void onExpanderAnimation() {
    if (_expanderAnimationController.status == AnimationStatus.dismissed) {
      setState(() => isExpanded = false);
    }
  }
}
