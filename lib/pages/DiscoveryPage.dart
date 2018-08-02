import 'package:flutter/material.dart';
import '../pages/OfflineActivityPage.dart';

class DiscoveryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new DiscoveryPageState();
}

class DiscoveryPageState extends State<DiscoveryPage> {
  final imagePaths = [
    "images/ic_discover_softwares.png",
    "images/ic_discover_git.png",
    "images/ic_discover_gist.png",
    "images/ic_discover_scan.png",
    "images/ic_discover_shake.png",
    "images/ic_discover_nearby.png",
    "images/ic_discover_pos.png",
  ];
  final titles = ["开源软件", "码云推荐", "代码片段", "扫一扫", "摇一摇", "码云封面人物", "线下活动"];

  static const double IMAGE_ICON_WIDTH = 30.0;
  static const double ARROW_ICON_WIDTH = 16.0;

  var rightErrorIcon = new Image.asset('images/ic_arrow_right.png',
      width: ARROW_ICON_WIDTH, height: ARROW_ICON_WIDTH);

  var titleTextStyle = new TextStyle(fontSize: 16.0);

  List listData = [];

  @override
  void initState() {
    initData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new ListView.builder(
            itemCount: titles.length,
            itemBuilder: (context, i) => renderRow(i)));
  }

  Widget renderRow(int i) {
    var item = new Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
        child: new Row(
          children: <Widget>[
            new Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                child: Image.asset(imagePaths[i],
                    width: IMAGE_ICON_WIDTH, height: IMAGE_ICON_WIDTH)),
            new Expanded(child: new Text(titles[i], style: titleTextStyle)),
            rightErrorIcon
          ],
        ));
    return new InkWell(
        child: item,
        onTap: () {
          onClickListItem(context, listData[i]);
        });
  }

  void initData() {
    for (int i = 0; i < titles.length; i++) {
      listData.add(new ListItem(titles[i], imagePaths[i]));
    }
  }

  void onClickListItem(BuildContext context, ListItem listData) {
    String title = listData.title;
    switch (title) {
      case "扫一扫":
        break;
      case "线下活动":
        Navigator.of(context).push(new MaterialPageRoute(
            builder: (context) => new OfflineActivityPage()));
        break;
      default:
        break;
    }
  }
}

class ListItem {
  String title;
  String icon;

  ListItem(this.title, this.icon);
}
