import 'package:flutter/material.dart';
import 'package:flutter_app_demo/fluttergo/components/cate_card.dart';
import 'package:flutter_app_demo/fluttergo/model/cat.dart';

// ignore: non_abstract_class_inherits_abstract_member_one
class WidgetPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new SecondPageState();
  }
}

// ignore: non_abstract_class_inherits_abstract_member_one
class SecondPageState extends State<WidgetPage> {
  List<Cat> categories = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (categories.length == 0) {
      return ListView(
        children: <Widget>[new Container()],
      );
    }
    return Container(
      color: Theme.of(context).backgroundColor,
      child: this.buildGrid(),
    );
  }

  Widget buildGrid() {
    List<Widget> titles = [];
    for (Cat item in categories) {
      titles.add(new CateCard(category: item));
    }
    return new ListView(
      children: titles,
    );
  }
}
