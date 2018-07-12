import 'package:flutter/material.dart';

void main() => runApp(new MutiLayoutApp());

class MutiLayoutApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Container
    Widget container = new Container(
      constraints: new BoxConstraints.expand(
        height: Theme.of(context).textTheme.display1.fontSize * 1.1 + 200.0,
      ),
      padding: const EdgeInsets.all(8.0),
      color: Colors.teal.shade700,
      alignment: Alignment.center,
      child: new Text(
        "Hello World",
        style:
            Theme.of(context).textTheme.display1.copyWith(color: Colors.white),
      ),
      foregroundDecoration: new BoxDecoration(
        image: new DecorationImage(
          image: new NetworkImage(
              "http://img.zcool.cn/community/0142135541fe180000019ae9b8cf86.jpg@1280w_1l_2o_100sh.png"),
          centerSlice: new Rect.fromLTRB(270.0, 180.0, 1360.0, 730.0),
        ),
      ),
      transform: new Matrix4.rotationZ(0.1),
    );

    //ConstrainedBox 不能放入listview
    Widget constrainedBox = new ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: const Card(
        child: const Text("Hello World"),
      ),
    );

    return new MaterialApp(
      title: "Muti Layout",
      theme: new ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Muti Layout"),
        ),
        body: ListView(
          children: <Widget>[container],
        ),
      ),
    );
  }
}
