import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import '../api/Api.dart';
import '../constants/Constants.dart';
import '../pages/NewsDetailPage.dart';
import '../utils/NetUtils.dart';
import '../widgets/CommonEndLine.dart';

class NewsListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new NewsListPageState();
}

class NewsListPageState extends State<NewsListPage> {
  var listData;
  var curPage = 1;
  var listTotalSize = 0;
  ScrollController _controller = new ScrollController();

  TextStyle titleTextStyle = new TextStyle(fontSize: 15.0);
  TextStyle subTitleStyle =
      new TextStyle(color: const Color(0xFFB5BDC0), fontSize: 12.0);

  NewsListPageState() {
    _controller.addListener(() {
      var maxScroll = _controller.position.maxScrollExtent;
      var pixels = _controller.position.pixels;
      if (maxScroll == pixels && listData.length < listTotalSize) {
        print("load more...");
        curPage++;
        getNewsList(true);
      }
    });
  }

  @override
  void initState() {
    getNewsList(false);
  }

  Future<Null> _pullToRefresh() async {
    curPage = 1;
    getNewsList(false);
    return null;
  }

  @override
  Widget build(BuildContext context) {
    if (listData == null) {
      return new Center(
        child: new CircularProgressIndicator(),
      );
    } else {
      Widget listView = new ListView.builder(
        itemCount: listData.length,
        itemBuilder: (context, i) => renderRow(i),
        controller: _controller,
      );
      return new RefreshIndicator(child: listView, onRefresh: _pullToRefresh);
    }
  }

  renderRow(int i) {
    var itemData = listData[i];
    if (itemData is String && itemData == Constants.END_LINE_TAG) {
      return new CommonEndLine();
    }
    //标题
    var titleRow = new Row(
      children: <Widget>[
        new Expanded(child: new Text(itemData['title'], style: titleTextStyle)),
      ],
    );
    //时间
    var timeRow = new Row(
      children: <Widget>[
        new Container(
          width: 20.0,
          height: 20.0,
          decoration: new BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFECECEC),
              image: new DecorationImage(
                  image: new NetworkImage(itemData['authorImg']),
                  fit: BoxFit.cover),
              border:
                  new Border.all(color: const Color(0xFFECECEC), width: 2.0)),
        ),
        new Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
          child: new Text(
            itemData['timeStr'],
            style: subTitleStyle,
          ),
        ),
        new Expanded(
            flex: 1,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                new Text(
                  "${itemData['commCount']}",
                  style: subTitleStyle,
                ),
                new Image.asset(
                  './images/ic_comment.png',
                  width: 16.0,
                  height: 16.0,
                ),
              ],
            ))
      ],
    );
    //大图
    var thumnbImgUrl = itemData['thumb'];
    var thumbImg = new Container(
      margin: const EdgeInsets.all(10.0),
      width: 60.0,
      height: 60.0,
      decoration: new BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFFECECEC),
          image: new DecorationImage(
              image: new ExactAssetImage('./images/ic_img_default.jpg'),
              fit: BoxFit.cover),
          border: new Border.all(color: const Color(0xFFECECEC), width: 2.0)),
    );
    if (thumnbImgUrl != null && thumnbImgUrl.length > 0) {
      thumbImg = new Container(
          margin: const EdgeInsets.all(10.0),
          width: 60.0,
          height: 60.0,
          decoration: new BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFECECEC),
              image: new DecorationImage(
                  image: new NetworkImage(thumnbImgUrl), fit: BoxFit.cover),
              border:
                  new Border.all(color: const Color(0xFFECECEC), width: 2.0)));
    }
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
                    padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 0.0),
                    child: timeRow,
                  ),
                ],
              ),
            )),
        new Padding(
            padding: const EdgeInsets.all(6.0),
            child: new Container(
              width: 100.0,
              height: 80.0,
              color: const Color(0xFFECECEC),
              child: new Center(
                child: thumbImg,
              ),
            ))
      ],
    );
    return new InkWell(
      child: row,
      onTap: () {
        Navigator.of(context).push(new MaterialPageRoute(
            builder: (ctx) => new NewsDetailPage(id: itemData['detailUrl'])));
      },
    );
  }

  void getNewsList(bool isLoadMore) {
    String url = Api.NEWS_LIST;
    url += "?pageIndex=$curPage&pageSize=10";
    print("newsListUrl: $url");
    NetUtils.get(url, (data) {
      if (data != null) {
        Map<String, dynamic> map = json.decode(data);
        if (map['code'] == 0) {
          var msg = map['msg'];
          listTotalSize = msg['news']['total'];
          var _listData = msg['news']['data'];
          setState(() {
            if (!isLoadMore) {
              listData = _listData;
            } else {
              List list1 = new List();
              list1.addAll(listData);
              list1.addAll(_listData);
              if (list1.length >= listTotalSize) {
                list1.add(Constants.END_LINE_TAG);
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
