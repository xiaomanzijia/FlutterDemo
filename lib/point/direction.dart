import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(BothDirectionPage());

class BothDirectionPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BothDirectionPageState();
}

class _BothDirectionPageState extends State<BothDirectionPage> {
  double _top = 0.0;
  double _left = 0.0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Stack(
        children: <Widget>[
          Positioned(
            top: _top,
            left: _left,
            child: GestureDetector(
              child: CircleAvatar(
                child: Text('A'),
              ),
              onVerticalDragUpdate: (DragUpdateDetails details) {
                setState(() {
                  _top += details.delta.dy;
                });
              },
              onHorizontalDragUpdate: (DragUpdateDetails details) {
                setState(() {
                  _left += details.delta.dx;
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
