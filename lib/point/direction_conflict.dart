import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(BothDirectionPage());

class BothDirectionPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BothDirectionPageState();
}

class _BothDirectionPageState extends State<BothDirectionPage> {
  double _left = 0.0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Stack(
        children: <Widget>[
          Positioned(
            left: _left,
            child: Listener(
              onPointerDown: (details) {
                print("down");
              },
              onPointerUp: (details) {
                //会触发
                print("up");
              },
              child: GestureDetector(
                child: CircleAvatar(
                  child: Text('A'),
                ),
                onHorizontalDragUpdate: (DragUpdateDetails details) {
                  setState(() {
                    _left += details.delta.dx;
                  });
                },
                onHorizontalDragEnd: (details) {
                  print("onHorizontalDragEnd");
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
