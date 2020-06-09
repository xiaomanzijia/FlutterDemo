import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(PointPage());

class PointPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PointPageState();
}

class _PointPageState extends State<PointPage> {
  PointerEvent _event;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Listener(
        child: Container(
          alignment: Alignment.center,
          color: Colors.blue,
          width: 300.0,
          height: 150.0,
          child: Text(
            _event?.toString() ?? '',
            style: TextStyle(color: Colors.white, fontSize: 15.0),
          ),
        ),
        onPointerDown: (PointerDownEvent event) => setState(() => _event = event),
        onPointerMove: (PointerMoveEvent event) => setState(() => _event = event),
        onPointerUp: (PointerUpEvent event) => setState(() => _event = event),
      ),
    );
  }
}
