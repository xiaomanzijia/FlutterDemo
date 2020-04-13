import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_demo/utils/EventBus.dart';

class ContainerRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //注册事件
    bus.on("login", (arg) {
      print("login接收到通知： $arg");
    });
    bus.on("logout", (arg) {
      print("logout接收到通知： $arg");
    });

    //发送事件
    bus.emit("login", "发送通知内容");
    bus.emit("logout", () => {print("logout发送通知内容")});

    return Container(
      margin: EdgeInsets.only(top: 50.0, left: 120.0),
      //容器补白
      constraints: BoxConstraints.tightFor(width: 200.0, height: 150.0),
      decoration: BoxDecoration(
          //背景装饰
          gradient: RadialGradient(
              //背景径向渐变
              colors: [Colors.red, Colors.orange],
              center: Alignment.topLeft,
              radius: .98),
          boxShadow: [
            //卡片阴影
            BoxShadow(
                color: Colors.black54,
                offset: Offset(2.0, 2.0),
                blurRadius: 4.0)
          ]),
      transform: Matrix4.rotationZ(.2),
      //卡片倾斜变换
      alignment: Alignment.center,
      //卡片内文字居中
      child: Text(
        "5.20",
        style: TextStyle(color: Colors.white, fontSize: 40.0),
      ),
    );
  }
}
