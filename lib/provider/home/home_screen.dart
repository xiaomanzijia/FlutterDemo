import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_demo/provider/home/filter_button.dart';
import 'package:flutter_app_demo/provider/localization.dart';
import 'package:flutter_app_demo/provider/todo_list_model.dart';
import 'package:provider/provider.dart';
import 'package:todos_app_core/todos_app_core.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {

  final _tab = ValueNotifier(_HomeScreenTab.todos);

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ProviderLocalizations.of(context).appTitle),
        actions: <Widget>[
          ValueListenableBuilder<_HomeScreenTab>(
            valueListenable: _tab,
            builder: (context, tab, child) => FilterButton(
              isActive: tab == _HomeScreenTab.todos,
            ),
          )
        ],
      ),
      body: Selector<TodoListModel, bool>(
        selector: (context, model) => model.isLoading,
        builder: (context, isLoading, child) {
          if (isLoading) {
            return Center(
              child: CircularProgressIndicator(
                key: ArchSampleKeys.todosLoading,
              ),
            );
          }

          return ValueListenableBuilder<_HomeScreenTab> (
            valueListenable: _tab,
            builder: (context, tab, child) {
              switch (tab) {
                case _HomeScreenTab.stats:
                  //TODO 统计
                  return const Text("11");
                case _HomeScreenTab.todos:
                default:
                  //TODO 列表
                  return Text("22");
              }
            },
          );
        },
      ),
      bottomNavigationBar: ValueListenableBuilder<_HomeScreenTab>(
        valueListenable: _tab,
        builder: (context, tab, child) {
          return BottomNavigationBar(
            key: ArchSampleKeys.tabs,
            currentIndex: _HomeScreenTab.values.indexOf(tab),
            onTap: (int index) => _tab.value = _HomeScreenTab.values[index],
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.list, key: ArchSampleKeys.todoTab,),
                title: Text(ArchSampleLocalizations.of(context).todos)
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.show_chart, key: ArchSampleKeys.statsTab,),
                  title: Text(ArchSampleLocalizations.of(context).stats)
              )
            ],
          );
        },
      ),
    );
  }

}

enum _HomeScreenTab {todos, stats}