import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(new ZPageView(
      itemCount: 3,
      itemBuilder: (BuildContext context, int index) {
        return Text('${index % 3}',);
      },
    ));

class ZPageView extends StatefulWidget {

  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;

  ZPageView({Key key, @required this.itemCount, @required this.itemBuilder});

  @override
  State<StatefulWidget> createState() => PageViewState();

}

class PageViewState extends State<ZPageView> {

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
    return _buildPageView();
  }


  @override
  void dispose() {
    _stopAutoplay();
    _pageController.dispose();
    super.dispose();
  }

  _buildPageView() {
    return Container(
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
                  _currentPageIndex = index % (widget.itemCount);
                });
              },
              itemCount: double.maxFinite.toInt(),
              itemBuilder: widget.itemBuilder,
            ),
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(widget.itemCount, (i) {
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
    );
  }

  void _startAutoplay() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      _pageController.animateToPage(_pageController.page.round() + 1, duration: Duration(milliseconds: 400), curve: Curves.easeOut);
    });
  }

  void _stopAutoplay() {
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    }
  }
}


