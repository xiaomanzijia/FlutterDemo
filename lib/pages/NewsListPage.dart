import 'package:flutter/material.dart';

class NewsListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new NewsListPageState();

}

class NewsListPageState extends State<NewsListPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Text("NewsListPage")
      ),
    );
  }

}