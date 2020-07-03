import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


void main() => runApp(new MyPageView());

class MyPageView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PageViewState();

}

class PageViewState extends State<MyPageView> {

  List<String> pageList = ['PageView1', 'PageView2', 'PageView3'];
  int _currentPageIndex = 0;

  Timer _timer;
  PageController _pageController;

  @override
  void initState() {
    _pageController = PageController();
    _startAutoplay();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Muti Layout",
      theme: new ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Muti Layout"),
        ),
        body: _buildPageView(),
      ),
    );
  }


  @override
  void dispose() {
    _stopAutoplay();
    super.dispose();
  }

  _buildPageView() {
    return Center(
      child: Container(
        height: 230,
        child: Stack(
          children: <Widget>[
            NotificationListener(
              onNotification: (ScrollNotification notification) {
                if (notification is ScrollStartNotification) {
                  if (notification.dragDetails != null) {
                    //by human
                    if (_timer != null) _stopAutoplay();
                  }
                } else if (notification is ScrollEndNotification) {
                  if (_timer == null) _startAutoplay();
                }

                return false;
              },
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (int index) {
                  setState(() {
                    _currentPageIndex = index % (pageList.length);
                  });
                },
                itemCount: 10000,
                itemBuilder: (context, index) {
                  return _buildPageViewItem(pageList[index % (pageList.length)]);
                },
              ),
            ),
//            GestureDetector(
//              onPanStart: (details) {
//                print('onPanStart');
//              },
//              onPanCancel: () {
//                print('onPanCancel');
//              },
//              onPanDown: (details) {
//                print('onPanDown');
//              },
//              onPanEnd: (details) {
//                print('onPanEnd');
//              },
//              onPanUpdate: (details) {
//                print('onPanUpdate');
//              },
////              onTap: () {
////                print('onTap');
////              },
////              onTapDown: (details) {
////                print('onTapDown');
////              },
////              onTapUp: (details) {
////                print('onTapUp');
////              },
////              onTapCancel: () {
////                print('onTapCancel');
////              },
////              onVerticalDragStart: (details) {
////                print('onVerticalDragStart');
////              },
////              onHorizontalDragStart: (details) {
////                print('onHorizontalDragStart');
////              },
////              onVerticalDragEnd: (details) {
////                print('onVerticalDragEnd');
////              },
////              onHorizontalDragEnd: (details) {
////                print('onHorizontalDragEnd');
////              },
////              onVerticalDragCancel: () {
////                print('onVerticalDragCancel');
////              },
////              onHorizontalDragCancel: () {
////                print('onHorizontalDragCancel');
////              },
////              onHorizontalDragUpdate: (details) {
////                print('onHorizontalDragUpdate');
////              },
////              onHorizontalDragDown: (details) {
////                print('onHorizontalDragDown');
////              },
////              onLongPressStart: (details) {
////                print('onLongPressStart');
////              },
////              onLongPress: () {
////                print('onLongPress');
////              },
////              onLongPressEnd: (details) {
////                print('onLongPressEnd');
////              },
////              onLongPressMoveUpdate: (details) {
////                print('onLongPressMoveUpdate');
////              },
////              onLongPressUp: () {
////                print('onLongPressUp');
////              },
//              child: PageView.builder(
//                controller: _pageController,
//                onPageChanged: (int index) {
//                  setState(() {
//                    _currentPageIndex = index % (pageList.length);
//                  });
//                },
//                itemCount: 10000,
//                itemBuilder: (context, index) {
//                  return _buildPageViewItem(pageList[index % (pageList.length)]);
//                },
//              ),
//            ),
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(pageList.length, (i) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentPageIndex == i
                              ? Colors.blue
                              : Colors.grey),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildPageViewItem(String txt, {Color color = Colors.red}) {
    return Container(
      color: color,
      alignment: Alignment.center,
      child: Text(
        txt,
        style: TextStyle(color: Colors.white, fontSize: 28),
      ),
    );
  }

  void _startAutoplay() {
    print('_startAutoplay');
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      _pageController.animateToPage(_pageController.page.round() + 1, duration: Duration(milliseconds: 400), curve: Curves.easeOut);
    });
  }

  void _stopAutoplay() {
    print('_stopAutoplay');
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    }
  }
}


