import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'red_dot_page.dart';


Future<void> main() async {
  runApp(MaterialApp(
    home: ShopDetailPage(),
  ));
}

class ShopDetailPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ShopDetailState();

}

class _ShopDetailState extends State<ShopDetailPage> {

  ScrollController _controller;

  @override
  void initState() {
    _controller = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: _controller,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverToBoxAdapter(
              child: Container(
                constraints: BoxConstraints.expand(
                    width: MediaQuery.of(context).size.width, height: 120.0),
                child: Center(
                  child: Text('店铺详情'),
                ),
              ),
            )
          ];
        },
        body: TabBarPage(_controller),
      ),
    );
  }

}

class TabBarPage extends StatefulWidget {

  final ScrollController _controller;


  TabBarPage(this._controller);

  @override
  State<StatefulWidget> createState() => TabBarPageState();
}

class TabBarPageState extends State<TabBarPage> with TickerProviderStateMixin {

  TabController _tabController;
  PageController _pageController;
  ScrollController _controller;
  ScrollPhysics _physics;
  final GlobalKey _shopIconKey = GlobalKey();

  final _tabs = List.generate(100, (index) => index);

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: _tabs.length);
    _pageController = PageController();
    _controller = ScrollController();
//    _physics = NeverScrollableScrollPhysics();
//    widget._controller.addListener(() {
//      print('父亲控件滑动监听，滑动距离:${widget._controller.offset}');
//      if (widget._controller.offset < 120.0) {
//        print('父亲控件滑动距离111 不可滑动');
//        _physics = NeverScrollableScrollPhysics();
//      } else {
//        print('父亲控件滑动距离111 可滑动');
//        _physics = null;
//        if (_controller == null) {
//          _controller = ScrollController();
//          _controller?.addListener(() {
//            if (_controller == null) return;
//            bool isDownDirection = _controller.position.userScrollDirection == ScrollDirection.forward;
//            print("左侧ListView滑动距离:${_controller.offset} 是否向下滑动:$isDownDirection");
//            if (isDownDirection && _controller.offset == 0) {
//              _controller = null;
//              setState(() {});
//            }
//          });
//        }
//      }
//      setState(() {});
//    });
//    _controller?.addListener(() {
//      if (_controller == null) return;
//      bool isDownDirection = _controller.position.userScrollDirection == ScrollDirection.forward;
//      print("左侧ListView滑动距离:${_controller.offset} 是否向下滑动:$isDownDirection");
//      if (isDownDirection && _controller.offset == 0) {
//        _controller = null;
//        setState(() {});
//      }
//
//    });
    super.initState();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    _pageController?.dispose();
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  color: Colors.yellow,
                  constraints: BoxConstraints.expand(
                      width: 120.0, height: MediaQuery.of(context).size.height),

//            child: SingleChildScrollView(
//              controller: widget._controller,
//              child: Column(
//                children: _tabs.map((index) => InkWell(
//                  onTap: () {
//                    _pageController.jumpToPage(index);
//                  },
//                  child: Text('Tab$index'),
//                )).toList(),
//              ),
//              ),
//            ),

                  child: ListView(
                    controller: _controller,
                    children: _tabs.map((index) => InkWell(
                      onTap: () {
                        _pageController.jumpToPage(index);
                      },
                      child: Text('Tab$index'),
                    )).toList(),
                  ),
                ),
                Container(
                  constraints: BoxConstraints.expand(
                      width: MediaQuery.of(context).size.width - 120.0,
                      height: MediaQuery.of(context).size.height),
                  child: PageView(
                    scrollDirection: Axis.vertical,
                    controller: _pageController,
                    physics: NeverScrollableScrollPhysics(),
                    children: _tabs
                        .map((tab) => KeepAlivePage(tab, widget._controller, _shopIconKey))
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 1,
            color: Colors.grey.withOpacity(0.5),
          ),
          Container(
            height: 60,
            color: Colors.white,
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Icon(
                    Icons.shop_two,
                    key: _shopIconKey,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class KeepAlivePage extends StatefulWidget {

  final ScrollController _controller;

  final int _tab;

  final GlobalKey _shopIconKey;


  KeepAlivePage(this._tab, this._controller, this._shopIconKey);

  @override
  State<StatefulWidget> createState() => KeepAlivePageState();

}


class KeepAlivePageState extends State<KeepAlivePage> with AutomaticKeepAliveClientMixin, TickerProviderStateMixin implements PositionChangedListener, ViewChangeListener {

  var _datas = [];
  ScrollController _controller;
  GlobalKey listViewKey = new GlobalKey();
  double lastTimePix = 0.0;
  int memoryPosition = 0;
  ScrollPhysics _physics;

  Offset _endOffset;

  final _horizonTabs = List.generate(12, (index) => Text('HorizonTab$index'));
  TabController _horizonTabController;

  @override
  void dispose() {
    _horizonTabController?.dispose();
    super.dispose();
  }

  @override
  void initState() {

    WidgetsBinding.instance.addPostFrameCallback((c) {
      // 获取「购物车」的位置
      _endOffset = (widget._shopIconKey.currentContext.findRenderObject() as RenderBox)
          .localToGlobal(Offset.zero);
    });

    _datas = List.generate(
        100,
        (index) {
          var key = GlobalKey();
          return Row(
            key: GlobalKey(),
            children: <Widget>[
              Expanded(
                child: Text(
                  'item$index',
                ),
              ),
              IconButton(
                key: key,
                icon: Icon(
                  Icons.shop_two,
                ),
                onPressed: () {

                  // 点击的时候获取当前 widget 的位置，传入 overlayEntry
                  var _overlayEntry = OverlayEntry(builder: (_) {
                    RenderBox box = key.currentContext.findRenderObject();
                    var offset = box.localToGlobal(Offset.zero);
                    return RedDotPage(
                      startPosition: offset,
                      endPosition: _endOffset,
                    );
                  });
                  // 显示Overlay
                  Overlay.of(key.currentContext).insert(_overlayEntry);
                  // 等待动画结束
                  Future.delayed(Duration(milliseconds: 800), () {
                    _overlayEntry.remove();
                    _overlayEntry = null;
                  });
                },
              )
            ],
          );
        });

    _horizonTabController =
        TabController(vsync: this, length: _horizonTabs.length);

    _controller = ScrollController();
    _controller.addListener(() {
      tabAnimateTo();
    });
    super.initState();
  }

  void tabAnimateTo() {
    double chileGlobalPositionY;
    double chileHeight;
    //获取ListView在屏幕中的位置
    double listViewGlobalPositionY = listViewKey.currentContext
        .findRenderObject()
        .getTransformTo(null)
        .getTranslation()
        .y;
    for (int i = memoryPosition; i <= _datas.length; i++) {
      if ((_datas[i].key as GlobalKey).currentContext == null) {
        continue;
      }
      //子控件在屏幕中的位置 用于计算第一个可见Item的位置
      chileGlobalPositionY = (_datas[i].key as GlobalKey)
          .currentContext
          .findRenderObject()
          .getTransformTo(null)
          .getTranslation()
          .y;
      //控件高度 用于计算第一个可见Item的位置
      chileHeight = (_datas[i].key as GlobalKey)
          .currentContext
          .findRenderObject()
          .paintBounds
          .size
          .height;
      //如果在屏幕中可见
      if (chileGlobalPositionY + chileHeight > listViewGlobalPositionY) {
        var index = i ~/ 10;
//        print("第一个可见的item is $i tab滚动到index:$index}");
        _horizonTabController.animateTo(i ~/ 10);
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Container(
              color: Colors.green,
              constraints: BoxConstraints.expand(
                  width: MediaQuery.of(context).size.width -
                      120.0,
                  height: 60.0),
              child: TabBar(
                tabs: _horizonTabs,
                isScrollable: true,
                controller: _horizonTabController,
              ),
            ),
            Center(
              child: Text(
                'Tab:${widget._tab}',
                style: TextStyle(color: Colors.black87),
              ),
            )
          ],
        ),
        Expanded(
          child: Container(
            color: Colors.blue,
            child: NotificationListener(
              child: ListView.builder(
                  physics: _physics,
                  key: listViewKey,
                  cacheExtent: 30.0,
                  itemCount: _datas.length,
//                controller: _controller,
                  itemBuilder: (context, index) {
                    return new LifeCycleWidget(
                      index: index,
                      changedListener: this,
                      child: _datas[index],
                    );
                  }),
              onNotification: (ScrollNotification scrollInfo) {
//              print('滑动方向${scrollInfo.metrics.axisDirection}');
//              if (scrollInfo.metrics.pixels == scrollInfo.metrics.minScrollExtent) {
//                print('滑到顶部啦！');
//              }
                tabAnimateTo();
                return true;
              },
            ),
          ),
        )
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  GlobalKey<State<StatefulWidget>> getListViewKey() {
    return listViewKey;
  }

  @override
  int getMemoryPosition() {
    return memoryPosition;
  }

  @override
  void onWidgetDispose(int index) {
    if(index == memoryPosition){
      memoryPosition ++;
//      print("onWidgetDispose memoryPosition is $memoryPosition");
    }
  }

  @override
  void onWidgetInit(int index) {
    if(index<memoryPosition){
      memoryPosition = index;
//      print("onWidgetInit memoryPosition is $memoryPosition");
    }
  }
}





class LifeCycleWidget extends StatefulWidget{

  final Widget child;
  final int index;
  final PositionChangedListener changedListener;

  LifeCycleWidget({
    this.child,
    this.index,
    this.changedListener,
  });

  @override
  State<StatefulWidget> createState() {
    return LifeCycleWidgetState();
  }
}


class LifeCycleWidgetState extends State<LifeCycleWidget>{
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void didChangeDependencies() {
    if(widget.changedListener!=null){
      widget.changedListener.onWidgetInit(widget.index);
    }
    super.didChangeDependencies();
  }

  @override
  void deactivate() {
    if(widget.changedListener!=null){
      widget.changedListener.onWidgetDispose(widget.index);
    }
    super.deactivate();
  }
}

abstract class PositionChangedListener{
  void onWidgetDispose(int index);
  void onWidgetInit(int index);
}

abstract class ViewChangeListener{
  GlobalKey getListViewKey();
  int getMemoryPosition();
}