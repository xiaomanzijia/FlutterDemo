import 'package:flutter/material.dart';

class OfflineActivityPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("线下活动", style: new TextStyle(color: Colors.white)),
          iconTheme: new IconThemeData(color: Colors.white),
        ),
        body: new DefaultTabController(
            length: 3,
            child: new Scaffold(
              appBar: new TabBar(
                tabs: <Widget>[
                  new Tab(
                    text: "强力推荐",
                  ),
                  new Tab(
                    text: "最新活动",
                  ),
                  new Tab(
                    text: "源创会",
                  )
                ],
                labelColor: Colors.black,
              ),
              body: new TabBarView(children: <Widget>[
                getRecBody(),
                getLastedtBody(),
                getYchBody()
              ]),
            )));
  }

  Widget getRecBody() {
    return new Center(
      child: new Text("强力推荐"),
    );
  }

  Widget getLastedtBody() {
    return new Center(
      child: new Text("最新活动"),
    );
  }

  Widget getYchBody() {
    return new Center(
      child: new Text("源创会"),
    );
  }
}
