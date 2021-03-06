import 'package:flutter/cupertino.dart';
import 'package:key_value_store_flutter/key_value_store_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todos_repository_local_storage/todos_repository_local_storage.dart';

import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(ProviderApp(
    repository: LocalStorageRepository(
      localStorage: KeyValueStorage(
        "change_notifier_provider_todos",
        FlutterKeyValueStore(await SharedPreferences.getInstance()),
//        WebKeyValueStore(window.localStorage),
      )
    ),
  ));
}