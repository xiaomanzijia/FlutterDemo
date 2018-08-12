import 'package:flutter/material.dart';

class MyInfoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new MyInfoPageState();
}

class MyInfoPageState extends State<MyInfoPage> {
  var titles = ["我的消息", "阅读记录", "我的博客", "我的问答", "我的活动", "我的团队", "邀请好友"];
  var imagePaths = [
    "images/ic_my_message.png",
    "images/ic_my_blog.png",
    "images/ic_my_blog.png",
    "images/ic_my_question.png",
    "images/ic_discover_pos.png",
    "images/ic_my_team.png",
    "images/ic_my_recommend.png"
  ];
  static const double IMAGE_ICON_WIDTH = 30.0;
  static const double ARROW_ICON_WIDTH = 16.0;

  var icons = [];
  var rightErrorIcon = new Image.asset('images/ic_arrow_right.png',
      width: ARROW_ICON_WIDTH, height: ARROW_ICON_WIDTH);

  var titleTextStyle = new TextStyle(fontSize: 16.0);

  var userAvatar;
  var userName;

  MyInfoPageState() {
    for (int i = 0; i < imagePaths.length; i++) {
      icons.add(getIconImage(imagePaths[i]));
    }
  }

  @override
  Widget build(BuildContext context) {
    var listView = new ListView.builder(
        itemCount: titles.length * 2,
        itemBuilder: (context, i) => renderRow(i));
    return listView;
  }

  Widget getIconImage(String imagePath) {
    return new Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
        child: new Image.asset(imagePath,
            width: IMAGE_ICON_WIDTH, height: IMAGE_ICON_WIDTH));
  }

  renderRow(int i) {
    if (i == 0) {
      var avatarContainer = new Container(
        color: const Color(0xff63ca6c),
        height: 200.0,
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              userAvatar == null
                  ? new Image.asset(
                "images/ic_avatar_default.png",
                width: 60.0,
              )
                  : new Container(
                width: 60.0,
                height: 60.0,
                decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent,
                    image: new DecorationImage(
                        image: new NetworkImage(userAvatar),
                        fit: BoxFit.cover),
                    border:
                    new Border.all(color: Colors.white, width: 2.0)),
              ),
              new Text(userName == null ? "点击头像登录" : userName,
                  style: new TextStyle(color: Colors.white, fontSize: 16.0))
            ],
          ),
        ),
      );
      return new GestureDetector(
        onTap: () {
          print("点击登录");
        },
        child: avatarContainer,
      );
    }
    --i;
    if (i.isOdd) {
      return new Divider(
        height: 1.0,
      );
    }
    i = i ~/ 2;
    String title = titles[i];
    var listItemContent = new Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
        child: new Row(
          children: <Widget>[
            icons[i],
            new Expanded(
              child: new Text(title, style: titleTextStyle),
            ),
            rightErrorIcon
          ],
        ));
    return new InkWell(
      child: listItemContent,
      onTap: () {
        _handleListItemClick(title);
      },
    );
  }

  //ITEM点击事件
  void _handleListItemClick(String title) {
    _showLoginDialog();
  }

  void _showLoginDialog() {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return new AlertDialog(
            title: new Text('提示'),
            content: new Text('没有登录，现在去登录吗？'),
            actions: <Widget>[
              new FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child:
                  new Text('取消', style: new TextStyle(color: Colors.red))),
              new FlatButton(onPressed: () {
                Navigator.of(context).pop();
                print("去登录");
              },
                  child: new Text(
                    '确定', style: new TextStyle(color: Colors.blue),))
            ],
          );
        });
  }
}
