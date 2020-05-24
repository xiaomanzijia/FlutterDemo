import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_app_demo/provider/models.dart';
import 'package:todos_repository_core/todos_repository_core.dart';

enum VisibilityFilter { all, active, completed }

class TodoListModel extends ChangeNotifier {
  final TodosRepository respository;

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


  TodoListModel({@required this.respository,
    VisibilityFilter filter,
    List<Todo> todos
  }): _todos = todos ?? [], _filter = filter ?? VisibilityFilter.all;

  Future loadTodos() {
    _isLoding = true;
    notifyListeners();

    return respository.loadTodos().then((loadedTodos) {
      _todos.addAll(loadedTodos.map(Todo.fromEntity));
      _isLoding = false;
      notifyListeners();
    }).catchError((err) {
      _isLoding = false;
      notifyListeners();
    });
  }

  List<Todo> get filteredTodos {
    return _todos.where((todo) {
      switch (filter) {
        case VisibilityFilter.active:
          return !todo.complete;
        case VisibilityFilter.completed:
          return todo.complete;
        case VisibilityFilter.all:
        default:
          return true;
      }
    }).toList();
  }

  void updateTodo(Todo todo) {
    assert(todo != null);
    assert(todo.id != null);
    var oldTodo = _todos.firstWhere((it) => it.id == todo.id);
    var replaceIndex = _todos.indexOf(oldTodo);
    _todos.replaceRange(replaceIndex, replaceIndex + 1, [todo]);
    notifyListeners();
    _uploadItems();
  }

  void _uploadItems() {
    respository.saveTodos(_todos.map((it)=>it.toEntity()).toList());
  }

  int get numCompleted =>
      todos.where((Todo todo) => todo.complete).toList().length;

  int get numActive =>
      todos.where((Todo todo) => !todo.complete).toList().length;
}
