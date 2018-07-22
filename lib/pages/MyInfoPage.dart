import 'package:flutter/material.dart';

class MyInfoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new MyInfoPageState();

}

class MyInfoPageState extends State<MyInfoPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Text("MyInfoPage")
      ),
    );
  }

}