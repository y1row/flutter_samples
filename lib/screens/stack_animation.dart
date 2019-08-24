import 'package:flutter/material.dart';
import 'package:flutter_samples/widgets/stack_animation_card.dart';

class StackAnimationScreen extends StatefulWidget {
  StackAnimationScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _StackAnimationScreenState createState() => _StackAnimationScreenState();
}

class _StackAnimationScreenState extends State<StackAnimationScreen> {
  static GlobalKey _stack = new GlobalKey();

  List<StackAnimationCard> _droppedCards;
  List<StackAnimationCard> _cards;

  @override
  void initState() {
    super.initState();
    reset();
  }

  reset() {
    setState(() {
      _droppedCards = [];
      _droppedCards.add(StackAnimationCard(color: Colors.transparent));

      _cards = [];
      _cards.add(StackAnimationCard(color: Colors.red));
      _cards.add(StackAnimationCard(color: Colors.blue));
      _cards.add(StackAnimationCard(color: Colors.green));
      _cards.add(StackAnimationCard(color: Colors.yellow));
      _cards.add(StackAnimationCard(color: Colors.black));
    });
  }

  drop() {
    setState(() {
      if (_cards.length > 0) {
        var dropCard = _cards.removeLast();
        _cards.add(StackAnimationCard(color: dropCard.color, isDropping: true));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Spacer(flex: 1),
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Container(
              alignment: Alignment.centerRight,
              child: RaisedButton(
                onPressed: reset,
                child: Text("reset"),
              ),
            ),
          ),
          Spacer(flex: 3),
          Stack(key: _stack, children: _droppedCards),
          Spacer(flex: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _cards,
          ),
          Spacer(flex: 3),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: drop,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
