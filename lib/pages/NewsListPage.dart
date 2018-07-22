import 'package:flutter/material.dart';
import '../api/Api.dart';
import '../utils/NetUtils.dart';
import 'dart:convert';

class NewsListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new NewsListPageState();
}

class NewsListPageState extends State<NewsListPage> {
  var listData;
  var curPage = 1;
  var listTotalSize = 0;

  TextStyle titleTextStyle = new TextStyle(fontSize: 15.0);


  @override
  void initState() {
    getNewsList(false);
  }

  @override
  Widget build(BuildContext context) {
    if (listData == null) {
      return new Center(
        child: new CircularProgressIndicator(),
      );
    } else {
      Widget listView = new ListView.builder(
          itemCount: listData.length * 2,
          itemBuilder: (context, i) => renderRow(i));
      return listView;
    }
  }

  renderRow(int i) {
    var itemData = listData[i];
    var titleRow = new Row(
      children: <Widget>[
        new Expanded(child: new Text(itemData['title'], style: titleTextStyle)),
      ],
    );
    var row = new Row(
      children: <Widget>[
        new Expanded(
            flex: 1,
            child: new Padding(
              padding: EdgeInsets.all(10.0),
              child: new Column(
                children: <Widget>[
                  titleRow,
                  new Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 0.0))
                ],
              ),
            ))
      ],
    );
    return new InkWell(
      child: row,
      onTap: () {},
    );
  }

  void getNewsList(bool isLoadMore) {
    String url = Api.NEWS_LIST;
    url += "?pageIndex=$curPage&pageSize=10";
    print("newsListUrl: $url");
    NetUtils.get(url, (data) {
      if(data != null) {
        Map<String, dynamic> map = json.decode(data);
        if(map['code']==0) {
          var msg = map['msg'];
          listTotalSize = msg['news']['total'];
          var _listData = msg['news']['data'];
          setState(() {
            if(!isLoadMore) {
              listData = _listData;
            } else {
              List list1 = new List();
              list1.addAll(listData);
              list1.addAll(_listData);
              if(list1.length >= listTotalSize) {
              }
              listData = list1;
            }
          });
        }
      }

    }, errorCallback: (e) {
      print("get news list error: $e");
    });
  }
}
