import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_app_demo/provider/models.dart';

enum VisibilityFilter {all, active, completed}

class TodoListModel extends ChangeNotifier {
  VisibilityFilter _filter;

  VisibilityFilter get filter => _filter;

  set filter(VisibilityFilter filter) {
    _filter = filter;
    notifyListeners();
  }

  List<Todo> _todos;

  UnmodifiableListView<Todo> get todos => UnmodifiableListView(_todos);

  bool _isLoding = false;

  bool get isLoading => _isLoding;


}