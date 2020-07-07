import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TabBarSecondPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TabBarSecondPageState();
}

class TabBarSecondPageState extends State<TabBarSecondPage>
    with SingleTickerProviderStateMixin {
  TabController _horizonTabController;

  final _horizonTabs = List.generate(7, (index) => Text('HorizonTab$index'));

  @override
  void initState() {
    _horizonTabController =
        TabController(vsync: this, length: _horizonTabs.length);
    super.initState();
  }

  @override
  void dispose() {
    _horizonTabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TabBar(
          tabs: _horizonTabs,
          isScrollable: true,
          controller: _horizonTabController,
        ),
        TabBarView(
          children: _horizonTabs
              .map((tab) => Center(
            child: Text("View:$tab"),
          ))
              .toList(),
          controller: _horizonTabController,
        )
      ],
    );
  }
}
