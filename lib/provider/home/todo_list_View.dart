

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_demo/provider/models.dart';
import 'package:flutter_app_demo/provider/todo_list_model.dart';
import 'package:provider/provider.dart';
import 'package:todos_app_core/todos_app_core.dart';

class TodoListView extends StatelessWidget {

  final void Function(BuildContext context, Todo todo) onRemove;


  TodoListView({Key key, @required this.onRemove}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<TodoListModel, List<Todo>>(
      selector: (context, model) => model.filteredTodos,
      builder: (context, todos, child) {
        return ListView.builder(
            key: ArchSampleKeys.todoList,
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];

              return Dismissible(
                key: ArchSampleKeys.todoItem(todo.id),
                onDismissed: (direction) => onRemove(context, todo),
                child: ListTile(
                  onTap: () {

                  },
                  leading: Checkbox(
                    key: ArchSampleKeys.todoItemCheckbox(todo.id),
                    value: todo.complete,
                    onChanged: (complete) {
                      Provider.of<TodoListModel>(context, listen: false)
                          .update(todo);
                    },
                  ),
                  title: Text(
                    todo.task,
                    key: ArchSampleKeys.todoItemTask(todo.id),
                    style: Theme.of(context).textTheme.title,
                  ),
                  subtitle: Text(
                    todo.note,
                    key: ArchSampleKeys.todoItemNote(todo.id),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.subhead,
                  ),
                ),
              );
            });
      },
    );
  }

}