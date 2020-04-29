

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_demo/provider/todo_list_model.dart';
import 'package:provider/provider.dart';
import 'package:todos_app_core/todos_app_core.dart';

class FilterButton extends StatelessWidget {

  final bool isActive;


  const FilterButton({this.isActive, Key key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !isActive,
      child: AnimatedOpacity(
        opacity: isActive ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 150),
        child: Consumer<TodoListModel>(
          builder: (context, model, child) {
            return PopupMenuButton<VisibilityFilter>(
              key: ArchSampleKeys.filterButton,
              tooltip: ArchSampleLocalizations.of(context).filterTodos,
              initialValue: model.filter,
              onSelected: (filter) => model.filter = filter,
              itemBuilder: (BuildContext context) => _items(context, model),
              icon: const Icon(Icons.filter_list),
            );
          },
        ),
      ),
    );
  }

  List<PopupMenuItem<VisibilityFilter>> _items(
      BuildContext context, TodoListModel store) {
    final activeStyle = Theme.of(context)
        .textTheme.body1.copyWith(color: Theme.of(context).accentColor);
    final defaultStyle = Theme.of(context).textTheme.body1;

    return [
      PopupMenuItem<VisibilityFilter>(
        key: ArchSampleKeys.allFilter,
        value: VisibilityFilter.all,
        child: Text(
          ArchSampleLocalizations.of(context).showAll,
          style: store.filter == VisibilityFilter.all ? activeStyle : defaultStyle,
        ),
      )
    ];
  }

}