import 'package:flutter/material.dart';

const String _kGalleryAssetsPackage = 'flutter_gallery_assets';


Future<void> main() async {
  runApp(MaterialApp(
    home: ScrollViewDemo(),
  ));
}

class _Page {
  _Page({this.label});

  final String label;

  String get id => label[0];

  @override
  String toString() => '$runtimeType("$label")';
}

class _CardData {
  const _CardData({this.title, this.imageAsset, this.imageAssetPackage});

  final String title;
  final String imageAsset;
  final String imageAssetPackage;
}

final Map<_Page, List<_CardData>> _allPages = <_Page, List<_CardData>>{
  new _Page(label: 'LEFT'): <_CardData>[
    const _CardData(
      title: 'Vintage Bluetooth Radio',
      imageAsset: 'shrine/products/radio.png',
      imageAssetPackage: _kGalleryAssetsPackage,
    ),
    const _CardData(
      title: 'Sunglasses',
      imageAsset: 'shrine/products/sunnies.png',
      imageAssetPackage: _kGalleryAssetsPackage,
    ),
    const _CardData(
      title: 'Clock',
      imageAsset: 'shrine/products/clock.png',
      imageAssetPackage: _kGalleryAssetsPackage,
    ),
    const _CardData(
      title: 'Red popsicle',
      imageAsset: 'shrine/products/popsicle.png',
      imageAssetPackage: _kGalleryAssetsPackage,
    ),
    const _CardData(
      title: 'Folding Chair',
      imageAsset: 'shrine/products/lawn_chair.png',
      imageAssetPackage: _kGalleryAssetsPackage,
    ),
    const _CardData(
      title: 'Green comfort chair',
      imageAsset: 'shrine/products/chair.png',
      imageAssetPackage: _kGalleryAssetsPackage,
    ),
    const _CardData(
      title: 'Old Binoculars',
      imageAsset: 'shrine/products/binoculars.png',
      imageAssetPackage: _kGalleryAssetsPackage,
    ),
    const _CardData(
      title: 'Teapot',
      imageAsset: 'shrine/products/teapot.png',
      imageAssetPackage: _kGalleryAssetsPackage,
    ),
    const _CardData(
      title: 'Blue suede shoes',
      imageAsset: 'shrine/products/chucks.png',
      imageAssetPackage: _kGalleryAssetsPackage,
    ),
  ],
//  new _Page(label: 'RIGHT'): <_CardData>[
//    const _CardData(
//      title: 'Beachball',
//      imageAsset: 'shrine/products/beachball.png',
//      imageAssetPackage: _kGalleryAssetsPackage,
//    ),
//    const _CardData(
//      title: 'Dipped Brush',
//      imageAsset: 'shrine/products/brush.png',
//      imageAssetPackage: _kGalleryAssetsPackage,
//    ),
//    const _CardData(
//      title: 'Perfect Goldfish Bowl',
//      imageAsset: 'shrine/products/fish_bowl.png',
//      imageAssetPackage: _kGalleryAssetsPackage,
//    ),
//  ],
};

class _CardDataItem extends StatelessWidget {
  const _CardDataItem({this.page, this.data});

  static const double height = 272.0;
  final _Page page;
  final _CardData data;

  @override
  Widget build(BuildContext context) {
    return new Card(
      child: new Padding(
        padding: const EdgeInsets.all(16.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new Align(
              alignment:
                  page.id == 'L' ? Alignment.centerLeft : Alignment.centerRight,
              child: new CircleAvatar(child: new Text('${page.id}')),
            ),
            new SizedBox(
              width: 144.0,
              height: 144.0,
              child: new Image.asset(
                data.imageAsset,
                package: data.imageAssetPackage,
                fit: BoxFit.contain,
              ),
            ),
            new Center(
              child: new Text(
                data.title,
                style: Theme.of(context).textTheme.title,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ScrollViewDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ScrollViewDemoState();
  }
}

class ScrollViewDemoState extends State {
  static const String routeName = '/material/tabs';
  ScrollController _controller = new ScrollController();
  ScrollController _controller2 = new ScrollController();

  double h = 0;
  double d15;
  double d20;
  double d25;
  double d30;
  double d35;
  double d40;
  double d45;
  double d50;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.addListener(() {
      d15 = 15;

      d20 = 20;
      d25 = 25;

      d30 = 30;
      d35 = 35;

      d50 = 50;

      d40 = 40;
      d45 = 45;

      double d60 = 60;
      double d70 = 70;

      double d80 = 80;
      double d85 = 85;

      double d90 = 90;

      double d100 = 100;

      setState(() {
        if ((_controller.offset > d100)) {
          h = d50;
        } else if ((_controller.offset > d90)) {
          h = d45;
        } else if ((_controller.offset > d80)) {
          h = d40;
        } else if ((_controller.offset > d70)) {
          h = d35;
        } else if ((_controller.offset > d60)) {
          h = d30;
        } else if ((_controller.offset > d50)) {
          h = d25;
        } else if ((_controller.offset > d40)) {
          h = d20;
        } else if ((_controller.offset > d30)) {
          h = d15;
        } else {
          h = 0;
        }
      });
    });
    double start = 0;
    _controller2.addListener(() {
//      print("---->_controller2:${_controller2.offset}");
      if ((_controller2.offset - start).abs() > 3) {
        _controller.jumpTo(_controller2.offset);
        start = _controller2.offset;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: _allPages.length,
      child: new Scaffold(
        backgroundColor: Colors.white,
        body: new NestedScrollView(
          controller: _controller,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              new SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                child: new SliverAppBar(
                  actions: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.share),
                      tooltip: 'Add new entry',
                      onPressed: () {
                        /* ... */
                      },
                    ),
                  ],
                  leading: Container(
                    child: Icon(Icons.backspace),
                    width: 0,
                    alignment: Alignment.center,
                  ),
                  title: Text("这是一个标题"),
                  pinned: true,
                  //固定在顶部
                  expandedHeight: 260,
                  // 这个高度必须比flexibleSpace高度大
                  forceElevated: innerBoxIsScrolled,
                  bottom: PreferredSize(
                      child: new Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                          color: Colors.white,
                        ),
                        height: h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                              child: InkWell(
                                child: Text(
                                  "导航一",
                                  style: TextStyle(
                                      color:
                                          h > 10 ? Colors.black : Colors.white),
                                ),
                                onTap: () {
                                  _controller2.animateTo(260,
                                      duration: new Duration(seconds: 1),
                                      curve: Curves.ease);
                                },
                              ),
                              alignment: Alignment.center,
                            ),
                            InkWell(
                                child: Text("导航二",
                                    style: TextStyle(
                                        color: h > 10
                                            ? Colors.black
                                            : Colors.white)),
                                onTap: () {
                                  _controller2.animateTo(600,
                                      duration: new Duration(seconds: 1),
                                      curve: Curves.ease);
                                  ;
                                })
                          ],
                        ),
                      ),
                      preferredSize: new Size(double.infinity, h)),
                  // 46.0为TabBar的高度，也就是tabs.dart中的_kTabHeight值，因为flutter不支持反射所以暂时没法通过代码获取
                  flexibleSpace: new Container(
                    child: new Column(
                      children: <Widget>[
                        new Expanded(
                          child: new Container(
                            height: 170,
                            decoration: BoxDecoration(color: Colors.white),
                            child: Stack(
                              fit: StackFit.expand,
                              children: <Widget>[
                                Image.asset(
                                  "images/test_1.png",
                                  fit: BoxFit.cover,
                                  height: 150,
                                ),
                                Stack(
                                  children: <Widget>[
                                    Container(
                                      height: 30,
                                      width: 375,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20)),
                                        color: Colors.white,
                                      ),
                                      child: Container(
                                        margin: EdgeInsets.only(left: 125),
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                              "这是测试的标题2",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15),
                                            ),
                                            Text(
                                              "描述",
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 12),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Container(
                                          margin: EdgeInsets.only(
                                              left: 10, right: 10),
                                          child: Row(
                                            children: <Widget>[
                                              Image.asset(
                                                "images/test_2.png",
                                                fit: BoxFit.fill,
                                                width: 116,
                                                height: 164,
                                              ),
                                              Column(
                                                children: <Widget>[
                                                  Text(
                                                    "这是测试的标题1",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  Text(
                                                    "副标题1",
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  ),
                                                  Text(
                                                    "副标题2",
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  ),
                                                  Text(
                                                    "副标题3",
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  ),
                                                  Text(
                                                    "副标题4",
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  )
                                                ],
                                              )
                                            ],
                                          )),
                                      height: h >= 20
                                          ? (h >= 30
                                              ? (h >= 35
                                                  ? (h >= 40 ? 0 : 80)
                                                  : 100)
                                              : 140)
                                          : 170,
                                    ),
                                  ],
                                  alignment: AlignmentDirectional.bottomEnd,
                                ),
                              ],
                            ),
                            width: double.infinity,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ];
          },
          body: new TabBarView(
            children: _allPages.keys.map((_Page page) {
              return new SafeArea(
                top: false,
                bottom: false,
                child: new Builder(
                  builder: (BuildContext context) {
                    return new CustomScrollView(
                      controller: _controller2,
                      key: new PageStorageKey<_Page>(page),
                      slivers: <Widget>[
                        new SliverOverlapInjector(
                          handle:
                              NestedScrollView.sliverOverlapAbsorberHandleFor(
                                  context),
                        ),
                        new SliverPadding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 16.0,
                          ),
                          sliver: new SliverFixedExtentList(
                            itemExtent: _CardDataItem.height,
                            delegate: new SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                                final _CardData data = _allPages[page][index];
                                return new Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8.0,
                                  ),
                                  child: new _CardDataItem(
                                    page: page,
                                    data: data,
                                  ),
                                );
                              },
                              childCount: _allPages[page].length,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              );
            }).toList(),
          ),
//        body: Column(children: <Widget>[],),
        ),
      ),
    );
  }
}
