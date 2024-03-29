import 'package:flutter/material.dart';

class StackAnimationCard extends StatefulWidget {
  final Color color;
  final bool isDropping;
  final GlobalKey tweenTarget;

  StackAnimationCard(
      {Key key, this.color, this.isDropping = false, this.tweenTarget})
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
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isDropping) {
      var target =
          widget.tweenTarget?.currentContext?.findRenderObject() as RenderBox;
      var translation = target?.getTransformTo(null)?.getTranslation();
      var size = target?.semanticBounds?.size;

      var from = context.findRenderObject() as RenderBox;
      var fromTranslation = from?.getTransformTo(null)?.getTranslation();

      var to = Offset((translation.x - fromTranslation.x) / from.size.width,
          (translation.y - fromTranslation.y) / from.size.height);

      animationController = AnimationController(
          vsync: this, duration: Duration(milliseconds: 250));
      tween = Tween<Offset>(begin: Offset.zero, end: to);
      animation = tween.animate(
          CurvedAnimation(parent: animationController, curve: Curves.easeIn));
      animationController.forward();

      return SlideTransition(
        position: animation,
        child: Card(
          color: widget.color,
          child: Container(
            width: MediaQuery.of(context).size.width / 6,
            height: MediaQuery.of(context).size.width / 6 * 1.6,
          ),
        ),
      );
    }

    return Card(
      color: widget.color,
      child: Container(
        width: MediaQuery.of(context).size.width / 6,
        height: MediaQuery.of(context).size.width / 6 * 1.6,
      ),
    );
  }
}
