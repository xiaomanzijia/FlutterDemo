import 'dart:ui';

import 'package:english_words/english_words.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(20.0),
      children: <Widget>[
        Text("A"),
        Text("B"),
        Text("C"),
        Text("D"),
      ],
    );
  }
}

class ListBuilderRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget divider1 = Divider(
      color: Colors.blue,
    );
    Widget divider2 = Divider(
      color: Colors.green,
    );

    return ListView.separated(
        itemCount: 100,
        separatorBuilder: (BuildContext context, int index) {
          return index % 2 == 0 ? divider1 : divider2;
        },
        //列表项构造器
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text("$index"),
          );
        });
  }
}

class InfiniteListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _InfiniteListViewState();
  }
}

class _InfiniteListViewState extends State<InfiniteListView> {
  static const loadingTag = "##loading##"; //表尾标记
  var _words = <String>[loadingTag];

  @override
  void initState() {
    super.initState();
    _retriveData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text("商品列表"),
        ),
        Expanded(
          child: ListView.separated(
              itemBuilder: (context, index) {
                //如果到了表尾
                if (_words[index] == loadingTag) {
                  //不足100条，继续获取数据
                  if (_words.length - 1 < 100) {
                    //获取数据
                    _retriveData();
                    //加载时显示loading
                    return Container(
                      padding: const EdgeInsets.all(16.0),
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: 24.0,
                        height: 24.0,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.0,
                        ),
                      ),
                    );
                  } else {
                    //已经加载了100条数据，不再获取数据
                    return Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        "没有更多了",
                        style: TextStyle(color: Colors.grey),
                      ),
                    );
                  }
                }
                //显示单词列表项
                return ListTile(
                  title: Text(_words[index]),
                );
              },
              separatorBuilder: (context, index) => Divider(
                    height: .0,
                  ),
              itemCount: _words.length),
        )
      ],
    );
  }

  void _retriveData() {
    Future.delayed(Duration(seconds: 2)).then((onValue) {
      _words.insertAll(_words.length - 1,
          generateWordPairs().take(20).map((e) => e.asPascalCase).toList());
      setState(() {
        //重新构建列表
      });
    });
  }
}
