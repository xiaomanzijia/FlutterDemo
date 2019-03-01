import 'package:flutter/material.dart';
import 'package:flutter_app_demo/fluttergo/components/markdown.dart';

class WidgetDemo extends StatefulWidget {
  final List<dynamic> contentList;
  final String docUrl;
  final String title;
  final String codeUrl;
  final Widget bottomNaviBar;

  WidgetDemo(
      {Key key,
      @required this.title,
      @required this.contentList,
      @required this.codeUrl,
      @required this.docUrl,
      this.bottomNaviBar})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => new _WidgetDemo();
}

class _WidgetDemo extends State<WidgetDemo> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  var _collectionIcons;

  @override
  Widget build(BuildContext context) {
    _collectionIcons = Icons.favorite;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          new IconButton(
              tooltip: 'goBack home',
              icon: Icon(Icons.home),
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/'));
              }),
          new IconButton(
              tooltip: 'collection',
              icon: Icon(_collectionIcons),
              onPressed: _getCollection),
          PopupMenuButton<String>(
            onSelected: _selectValue,
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(
                      value: 'doc',
                      child: ListTile(
                        leading: Icon(
                          Icons.library_books,
                          size: 22.0,
                        ),
                        title: Text('查看文档'),
                      )),
                  const PopupMenuDivider(),
                  const PopupMenuItem<String>(
                      value: 'code',
                      child: ListTile(
                        leading: Icon(
                          Icons.code,
                          size: 22.0,
                        ),
                        title: Text('查看Demo'),
                      ))
                ],
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(0.0),
          children: <Widget>[
            Column(
              children: _buildContent(),
            )
          ],
        ),
      ),
      bottomNavigationBar:
          (widget.bottomNaviBar is Widget) ? widget.bottomNaviBar : null,
    );
  }

  void _getCollection() {}

  void _selectValue(String value) {}

  List<Widget> _buildContent() {
    List<Widget> _list = [
      SizedBox(
        height: 10.0,
      )
    ];
    widget.contentList.forEach((item) {
      if (item.runtimeType == String) {
        _list.add(MarkdownBody(item));
        _list.add(
          SizedBox(
            height: 20.0,
          ),
        );
      } else {
        _list.add(item);
      }
    });
    return _list;
  }
}
