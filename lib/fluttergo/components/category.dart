import 'package:flutter/material.dart';
import 'package:flutter_app_demo/fluttergo/components/widget_item_container.dart';
import 'package:flutter_app_demo/fluttergo/model/cat.dart';
import 'package:flutter_app_demo/fluttergo/model/widget.dart';
import 'package:flutter_app_demo/fluttergo/widget/index.dart';

class CategoryHome extends StatefulWidget {
  final String name;

  CategoryHome(this.name);

  @override
  State<StatefulWidget> createState() {
    return new _CategoryHome();
  }
}

class _CategoryHome extends State<CategoryHome> {
  String title = '';

  // 显示列表 cat or widget;
  List<Cat> categories = [];
  List<WidgetPoint> widgetPoints = [];
  List<Cat> catHistory = new List();

  CatControlModel catControl = new CatControlModel();
  WidgetControlModel widgetControl = new WidgetControlModel();
  List widgetDemosList = new WidgetDemoList().getDemos();

  @override
  void initState() {
    super.initState();
    this.getCatByName(widget.name).then((Cat cat) {
      catHistory.add(cat);
      searchCatOrWigdet();
    });
  }

  Future<Cat> getCatByName(String name) async {
    return await catControl.getCatByName(name);
  }

  void searchCatOrWigdet() async {
    // 假设进入这个界面的parent一定存在
    Cat parentCat = catHistory.last;

    // 继续搜索显示下一级depth: depth + 1, parentId: parentCat.id
    List<Cat> _categories =
        await catControl.getList(new Cat(parentId: parentCat.id));
    List<WidgetPoint> _widgetPoints = new List();
    if (_categories.isEmpty) {
      _widgetPoints =
          await widgetControl.getList(new WidgetPoint(catId: parentCat.id));
    }

    this.setState(() {
      categories = _categories;
      title = parentCat.name;
      widgetPoints = _widgetPoints;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: WillPopScope(
          child: ListView(
            children: <Widget>[
              _buildContent(),
            ],
          ),
          onWillPop: null),
    );
  }

  Widget _buildContent() {
    WidgetItemContainer wiContaienr = WidgetItemContainer(
        columnCount: 3, categories: categories, isWidgetPoint: false);
    if (widgetPoints.length > 0) {
      wiContaienr = WidgetItemContainer(
          categories: widgetPoints, columnCount: 3, isWidgetPoint: true);
    }
    return Container(
      padding: const EdgeInsets.only(bottom: 10.0, top: 5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
            image: AssetImage('assets/images/paimaiLogo.png'),
            alignment: Alignment.bottomRight),
      ),
      child: wiContaienr,
    );
  }
}
