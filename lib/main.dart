import 'package:nabeey/app.dart';
import 'package:flutter/material.dart';
import 'package:nabeey/utils/local_storage/storage_utility.dart';

Future<void> main() async {
  /// Widgets Binding
  WidgetsFlutterBinding.ensureInitialized();

  /// Hive Local Storage
  LocalStorage.initHive();

  runApp(const App());
}
