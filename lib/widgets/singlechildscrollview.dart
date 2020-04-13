import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SingleChildScrollViewRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String str = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    return Scrollbar(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Column(
              //动态创建一个List<Widget>
              children: str
                  .split("")
                  .map((c) => Text(
                        c,
                        textScaleFactor: 2.0, //字体为原来的2倍
                      ))
                  .toList()),
        ),
      ),
    );
  }
}
