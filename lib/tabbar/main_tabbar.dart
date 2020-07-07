import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


Future<void> main() async {
  runApp(MaterialApp(
    home: TabBarPage(),
  ));
}

class TabBarPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TabBarPageState();
}

class TabBarPageState extends State<TabBarPage> with TickerProviderStateMixin {

  TabController _tabController;
  PageController _pageController;

  final _tabs = List.generate(100, (index) => index);

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: _tabs.length);
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              color: Colors.yellow,
              constraints: BoxConstraints.expand(
                  width: 120.0, height: MediaQuery.of(context).size.height),
              child: ListView(
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
                    .map((tab) => KeepAlivePage(tab))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class KeepAlivePage extends StatefulWidget {

  final int _tab;

  KeepAlivePage(this._tab);

  @override
  State<StatefulWidget> createState() => KeepAlivePageState();

}


class KeepAlivePageState extends State<KeepAlivePage> with AutomaticKeepAliveClientMixin, TickerProviderStateMixin implements PositionChangedListener, ViewChangeListener {

  final _datas = List.generate(100, (index) => Text(
            'item$index',
            key: GlobalKey(),
          ));
  ScrollController _controller;
  GlobalKey listViewKey = new GlobalKey();
  double lastTimePix = 0.0;
  int memoryPosition = 0;

  final _horizonTabs = List.generate(12, (index) => Text('HorizonTab$index'));
  TabController _horizonTabController;

  @override
  void dispose() {
    _horizonTabController?.dispose();
    super.dispose();
  }

  @override
  void initState() {

    _horizonTabController =
        TabController(vsync: this, length: _horizonTabs.length);

    _controller = ScrollController();
    _controller.addListener(() {
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
          print("第一个可见的item is $i tab滚动到index:$index}");
          _horizonTabController.animateTo(i ~/ 10);
          break;
        }
      }
    });
    super.initState();
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
        Container(
          color: Colors.blue,
          constraints: BoxConstraints.expand(
              width: MediaQuery.of(context).size.width - 120.0,
              height: MediaQuery.of(context).size.height - 60.0),
          child: ListView.builder(
              key: listViewKey,
              cacheExtent: 30.0,
              itemCount: _datas.length,
              controller: _controller,
              itemBuilder: (context, index) {
                return new LifeCycleWidget(
                  index: index,
                  changedListener: this,
                  child: _datas[index],
                );
              }),
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
      print("onWidgetDispose memoryPosition is $memoryPosition");
    }
  }

  @override
  void onWidgetInit(int index) {
    if(index<memoryPosition){
      memoryPosition = index;
      print("onWidgetInit memoryPosition is $memoryPosition");
    }
  }
}





class LifeCycleWidget extends StatefulWidget{

  final Widget child;
  final int index;
  final PositionChangedListener changedListener;

  LifeCycleWidget({
    @required this.child,
    @required this.index,
    @required this.changedListener,
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