import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(GesturePage());

class GesturePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GesturePageState();
}

class _GesturePageState extends State<GesturePage> {
  double _top = 0.0;
  double _left = 0.0;

  double _width = 200.0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Stack(
        children: <Widget>[
          Container(
            width: _width,
            height: _width,
            color: Colors.red,
          ),
          Positioned(
            top: _top,
            left: _left,
            child: GestureDetector(
              child: CircleAvatar(child: Text('A'),),
//              onPanDown: (DragDownDetails e) {
//                //打印手指按下的位置(相对于屏幕)
//                print("用户手指按下:${e.globalPosition}");
//              },
//              //手指滑动时会触发此回调
//              onPanUpdate: (DragUpdateDetails e) {
//                setState(() {
//                  _left += e.delta.dx;
//                  _top += e.delta.dy;
//                });
//              },
//              onPanEnd: (DragEndDetails e) {
//                //打印滑动结束时在x、y轴上的速度
//                print(e.velocity);
//              },
              onScaleUpdate: (ScaleUpdateDetails details) {
                setState(() {
                  _width = 200 * details.scale.clamp(.8, 10.0);
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
