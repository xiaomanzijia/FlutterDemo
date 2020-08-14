import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(appBar: AppBar(), body: Example()));
  }
}

class Example extends StatefulWidget {
  @override
  _ExampleState createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  PageController _pageController;
  ScrollController _listScrollController;
  ScrollController _activeScrollController;
  Drag _drag;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _listScrollController = ScrollController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _listScrollController.dispose();
    super.dispose();
  }

  void _handleDragStart(DragStartDetails details) {
    if (_listScrollController.hasClients &&
        _listScrollController.position.context.storageContext != null) {
      final RenderBox renderBox = _listScrollController
          .position.context.storageContext
          .findRenderObject();
      if (renderBox.paintBounds
          .shift(renderBox.localToGlobal(Offset.zero))
          .contains(details.globalPosition)) {
        print("切换到listScrollController");
        _activeScrollController = _listScrollController;
        _drag = _activeScrollController.position.drag(details, _disposeDrag);
        return;
      }
    }
    print("切换到pageController 11");
    _activeScrollController = _pageController;
    _drag = _pageController.position.drag(details, _disposeDrag);
  }

  void _handleDragUpdate(DragUpdateDetails details) {

    if (_activeScrollController == _listScrollController) {
      print('列表移动pixels:${_activeScrollController.offset.roundToDouble()}');
    }

    var scrollDirection = _activeScrollController.position.userScrollDirection;
    if (scrollDirection == ScrollDirection.forward) {
      print('向下滑');
    } else if (scrollDirection == ScrollDirection.reverse) {
      print('向上滑');
    }

    if (_activeScrollController == _listScrollController
        && ((scrollDirection == ScrollDirection.reverse) && _activeScrollController.offset.roundToDouble() >=
                _activeScrollController.position.maxScrollExtent
                    .roundToDouble() ||
            (scrollDirection == ScrollDirection.forward) && _activeScrollController.offset < 3.0)) {
      print("切换到pageController 22");
      _activeScrollController = _pageController;
      _drag?.cancel();
      _drag = _pageController.position.drag(
          DragStartDetails(
              globalPosition: details.globalPosition,
              localPosition: details.localPosition),
          _disposeDrag);
    }
    _drag?.update(details);
  }

  void _handleDragEnd(DragEndDetails details) {
    _drag?.end(details);
  }

  void _handleDragCancel() {
    _drag?.cancel();
  }

  void _disposeDrag() {
    _drag = null;
  }

  @override
  Widget build(BuildContext context) {

//    return RawGestureDetector(
//      gestures: <Type, GestureRecognizerFactory> {
//        VerticalDragGestureRecognizer : GestureRecognizerFactoryWithHandlers<VerticalDragGestureRecognizer> (
//            () => VerticalDragGestureRecognizer(),
//            (instance) {
//
//            }
//        )
//      },
//    );

    return RawGestureDetector(
        gestures: <Type, GestureRecognizerFactory>{
          VerticalDragGestureRecognizer: GestureRecognizerFactoryWithHandlers<
                  VerticalDragGestureRecognizer>(
              () => VerticalDragGestureRecognizer(),
              (VerticalDragGestureRecognizer instance) {
            instance
              ..onStart = _handleDragStart
              ..onUpdate = _handleDragUpdate
              ..onEnd = _handleDragEnd
              ..onCancel = _handleDragCancel;
          })
        },
        behavior: HitTestBehavior.opaque,
        child: PageView(
          controller: _pageController,
          scrollDirection: Axis.vertical,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            ListView(
                controller: _listScrollController,
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(25, (int index) {
                  return ListTile(title: Text('Item $index'));
                })),
            Center(child: Text('Page 2')),
            ListView(
                controller: _listScrollController,
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(25, (int index) {
                  return ListTile(title: Text('Item $index'));
                })),
            ListView(
                controller: _listScrollController,
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(25, (int index) {
                  return ListTile(title: Text('Item $index'));
                })),
            Center(child: Text('Page 2')),
            ListView(
                controller: _listScrollController,
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(25, (int index) {
                  return ListTile(title: Text('Item $index'));
                })),
          ],
        ));
  }
}
