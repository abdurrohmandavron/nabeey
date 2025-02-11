import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'app.dart';
import 'bindings/service_locator.dart' as service_locator;
import 'utils/local_storage/storage_utility.dart';

Future<void> main() async {
  /// Widgets Binding
  WidgetsFlutterBinding.ensureInitialized();

  /// Init Local Storage Hive
  await LocalStorage.initHive();

  /// Init service locator
  service_locator.setupLocator();

  /// Load environment variables
  await dotenv.load();

  /// Run the App
  runApp(const App());
}
