import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_demo/provider/localization.dart';
import 'package:flutter_app_demo/provider/todo_list_model.dart';
import 'package:provider/provider.dart';
import 'package:todos_app_core/todos_app_core.dart';

import 'home/home_screen.dart';

class ProviderApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TodoListModel(),
      child: MaterialApp(
        theme: ArchSampleTheme.theme,
        localizationsDelegates: [
          ArchSampleLocalizationsDelegate(),
          ProviderLocalizationsDelegate(),
        ],
        onGenerateTitle: (context) =>
        ProviderLocalizations.of(context).appTitle,
        routes: {
          ArchSampleRoutes.home: (context) => HomeScreen(),
          ArchSampleRoutes.addTodo: (context) => Text("addTodo"),
        },
      ),
    );
  }


}