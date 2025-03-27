import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:nabeey/data/models/user_model.dart';

class LocalStorage {
  static final LocalStorage _instance = LocalStorage._internal();

  factory LocalStorage() => _instance;

  LocalStorage._internal();

  static Future<void> _initHive() async {
    // Register your adapters for the data types you want to store
    Hive.registerAdapter(UserModelAdapter());
  }

  static Future<void> initHive() async {
    final appDocumentDirectory = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);
    await _initHive();
    await Hive.openBox('general');
  }

  Future<void> openBox(String boxName) async {
    if (!Hive.isBoxOpen(boxName)) {
      await Hive.openBox(boxName);
    }
  }

  T? readData<T>(String boxName, String key) {
    final box = Hive.box(boxName);
    return box.get(key) as T?;
  }

  Future<void> clearAll(String boxName) async {
    final box = Hive.box(boxName);
    await box.clear();
  }

  Future<void> removeData(String boxName, String key) async {
    final box = Hive.box(boxName);
    await box.delete(key);
  }

  Future<void> saveData<T>(String boxName, String key, T value) async {
    final box = Hive.box(boxName);
    await box.put(key, value);
  }
}
