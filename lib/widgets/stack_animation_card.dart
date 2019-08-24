import 'package:flutter/material.dart';

class StackAnimationCard extends StatefulWidget {
  final Color color;
  final bool isDropping;

  StackAnimationCard({Key key, this.color, this.isDropping = false})
      : super(key: key);

  @override
  _StackAnimationCardState createState() => _StackAnimationCardState();
}

class _StackAnimationCardState extends State<StackAnimationCard>
    with TickerProviderStateMixin {
  Tween tween;
  Animation animation;
  AnimationController animationController;

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    tween = Tween<Offset>(begin: Offset.zero, end: Offset(-2, -1.4));
    animation = tween.animate(animationController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isDropping) {
      animationController.forward();
      return SlideTransition(
        position: animation,
        child: Card(
          color: widget.color,
          child: Container(
            width: 70,
            height: 100,
          ),
        ),
      );
    }

    return Card(
      color: widget.color,
      child: Container(
        width: 70,
        height: 100,
      ),
    );
  }
}
