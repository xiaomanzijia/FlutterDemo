import 'package:flutter/material.dart';
import 'package:flutter_app_demo/fluttergo/components/cate_card.dart';
import 'package:flutter_app_demo/fluttergo/model/cat.dart';

// ignore: non_abstract_class_inherits_abstract_member_one
class WidgetPage extends StatefulWidget {
  final db;
  final CatControlModel catModel;

  WidgetPage(this.db)
      : catModel = new CatControlModel(),
        super();

  @override
  State<StatefulWidget> createState() {
    return new SecondPageState(catModel);
  }
}

// ignore: non_abstract_class_inherits_abstract_member_one
class SecondPageState extends State<WidgetPage>
    with AutomaticKeepAliveClientMixin {
  List<Cat> categories = [];
  CatControlModel catModel;

  SecondPageState(this.catModel) : super();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    renderCats();
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

  void renderCats() {
    catModel.getList().then((List data) {
      if (data.isNotEmpty) {
        setState(() {
          categories = data;
        });
      }
    });
  }
}
