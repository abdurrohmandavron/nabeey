import 'package:get_storage/get_storage.dart';

class LocalStorage {
  static final LocalStorage _instance = LocalStorage._internal();

  factory LocalStorage() => _instance;

  LocalStorage._internal();

  final _storage = GetStorage();

  T? readData<T>(String key) => _storage.read<T>(key);

  Future<void> clearAll() async => await _storage.erase();

  Future<void> removeData(String key) async => await _storage.remove(key);

  Future<void> saveData<T>(String key, T value) async => await _storage.write(key, value);
}
