import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_demo/fluttergo/components/widget_item.dart';
import 'package:flutter_app_demo/fluttergo/routers/app.dart';
import 'package:flutter_app_demo/fluttergo/widget/index.dart';

class WidgetItemContainer extends StatelessWidget {
  final int columnCount; //一行几个
  final List<dynamic> categories;
  final bool isWidgetPoint;

  final List widgetDemosList = new WidgetDemoList().getDemos();

  WidgetItemContainer(
      {Key key,
      @required this.columnCount,
      @required this.categories,
      @required this.isWidgetPoint})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: _buildColumns(context));
  }

  List<Widget> _buildColumns(BuildContext context) {
    List<Widget> _listWidget = [];
    List<Widget> _listRows = [];
    int addI;
    for (int i = 0, length = categories.length; i < length; i += columnCount) {
      _listRows = [];
      for (int innerI = 0; innerI < columnCount; innerI++) {
        addI = innerI + i;
        if (addI < length) {
          dynamic item = categories[addI];
          _listRows.add(Expanded(
              flex: 1,
              child: WidgetItem(
                title: item.name,
                onTap: () {
                  if (isWidgetPoint) {
                    String targetName = item.name;
                    String tartgetRouter = 'category/error/404';
                    widgetDemosList.forEach((item) {
                      if (item.name == targetName) {
                        tartgetRouter = item.routerName;
                      }
                    });
                    print("router---> $tartgetRouter");
                    Application.router.navigateTo(context, "$tartgetRouter",
                        transition: TransitionType.inFromRight);
                  } else {
                    print("router---> /category/${item.name}");
                    Application.router.navigateTo(
                        context, "/category/${item.name}",
                        transition: TransitionType.inFromRight);
                  }
                },
                index: addI,
                totalCount: length,
                rowLength: columnCount,
                textSize: isWidgetPoint ? 'middle' : 'small',
              )));
        } else {
          _listRows.add(Expanded(flex: 1, child: Container()));
        }
      }
      _listWidget.add(Row(
        children: _listRows,
      ));
    }
    return _listWidget;
  }
}
