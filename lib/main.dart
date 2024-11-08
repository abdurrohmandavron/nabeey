import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'app.dart';
import 'bindings/service_locator.dart';
import 'utils/local_storage/storage_utility.dart';

Future<void> main() async {
  /// Widgets Binding
  WidgetsFlutterBinding.ensureInitialized();

  /// Hive Local Storage
  await LocalStorage.initHive();

  /// Initialize the service locator
  setupLocator();

  /// Load environment variables
  await dotenv.load();

  /// Run the App
  runApp(const App());
}
