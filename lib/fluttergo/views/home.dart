import 'package:flutter/material.dart';
import 'package:flutter_app_demo/fluttergo/routers/app.dart';
import 'package:flutter_app_demo/fluttergo/utils/provider.dart';
import 'package:flutter_app_demo/fluttergo/views/first_page/first_page.dart';
import 'package:flutter_app_demo/fluttergo/views/widget_page/widget_page.dart';

class AppPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _MyHomePageState();
  }
}

class _MyHomePageState extends State<AppPage>
    with SingleTickerProviderStateMixin {
  TabController controller;

  List<Widget> myTabs = [];

  static List tabData = [
    {'text': '业界动态', 'icon': new Icon(Icons.language)},
    {'text': 'WIDGET', 'icon': new Icon(Icons.extension)},
    {'text': '组件收藏', 'icon': new Icon(Icons.favorite)},
    {'text': '关于手册', 'icon': new Icon(Icons.import_contacts)}
  ];

  String appBarTitle = tabData[0]['text'];

  @override
  void initState() {
    super.initState();
    controller = new TabController(initialIndex: 0, vsync: this, length: 4);
    for (int i = 0; i < tabData.length; i++) {
      myTabs.add(new Tab(text: tabData[i]['text'], icon: tabData[i]['icon']));
    }
    controller.addListener(() {
      if (controller.indexIsChanging) {
        _onTabChange();
      }
    });
    Application.controller = controller;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var db = Provider.db;
    return new Scaffold(
      appBar: new AppBar(title: buildSearchInput(context)),
      body: new TabBarView(controller: controller, children: <Widget>[
        new FirstPage(),
        new WidgetPage(db),
        new FirstPage(),
        new FirstPage(),
      ]),
      bottomNavigationBar: Material(
        color: const Color(0xFFF0EEEF),
        child: SafeArea(
            child: Container(
          height: 65,
          decoration: BoxDecoration(
              color: const Color(0xFFF0F0F0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: const Color(0xFFd0d0d0),
                  blurRadius: 3.0,
                  spreadRadius: 2.0,
                  offset: Offset(-1.0, -1.0),
                )
              ]),
          child: TabBar(
              controller: controller,
              indicatorColor: Theme.of(context).primaryColor,
              //tab标签的下划线颜色,
              indicatorWeight: 3.0,
              labelColor: Theme.of(context).primaryColor,
              unselectedLabelColor: const Color(0xFF8E8E8E),
              tabs: myTabs),
        )),
      ),
    );
  }

  Widget buildSearchInput(BuildContext context) {
    return null;
  }

  void _onTabChange() {
    if (this.mounted) {
      this.setState(() {
        appBarTitle = tabData[controller.index]['text'];
      });
    }
  }
}
