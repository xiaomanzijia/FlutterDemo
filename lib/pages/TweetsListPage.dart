import 'package:flutter/material.dart';

class TweetsListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new TweetsListPageState();

}

class TweetsListPageState extends State<TweetsListPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Text("TweetsListPage")
      ),
    );
  }

}