//如何更新widget
import 'package:flutter/material.dart';
import 'package:flutter_app_demo/widgets/container.dart';
import 'package:flutter_app_demo/widgets/counter.dart';
import 'package:flutter_app_demo/widgets/decorationbox.dart';
import 'package:flutter_app_demo/widgets/expand.dart';
import 'package:flutter_app_demo/widgets/flowdelegate.dart';
import 'package:flutter_app_demo/widgets/grid.dart';
import 'package:flutter_app_demo/widgets/listtest.dart';
import 'package:flutter_app_demo/widgets/paddingtest.dart';
import 'package:flutter_app_demo/widgets/stack.dart';
import 'package:flutter_app_demo/widgets/switch.dart';
import 'package:flutter_app_demo/widgets/tapboxb.dart';
import 'package:flutter_app_demo/widgets/tapboxc.dart';
import 'package:flutter_app_demo/widgets/validatetest.dart';
import 'package:flutter_app_demo/widgets/wrap.dart';

import 'widgets/singlechildscrollview.dart';

void main() => runApp(new SampleApp());

class SampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Sample App",
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new SampleAppPage(),
    );
  }
}

class SampleAppPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _SampleAppPageState();
}

class _SampleAppPageState extends State<SampleAppPage> {
  String textToShow = "I like Flutter";

  void _updateText() {
    setState(() {
      textToShow = "Flutter is Awesome!";
    });

    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return new Scaffold(
        appBar: AppBar(
          title: Text("Counter Demo"),
        ),
        body: ContainerRoute(),
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Sample App"),
      ),
      body: new Center(
        child: new Text(textToShow),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _updateText,
        tooltip: "Update Text",
        child: new Icon(Icons.update),
      ),
    );
  }
}
