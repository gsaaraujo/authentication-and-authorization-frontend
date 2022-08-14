import 'package:hive/hive.dart';
import 'package:authentication_and_authorization_frontend/app/services/local_storage/interfaces/local_storage.dart';

class HiveLocalStorage implements ILocalStorage {
  @override
  Future<void> add<T>(String key, T value) async {
    final box = await Hive.openBox('BOX');
    await box.put(key, value);
  }

  @override
  Future<void> delete(String key) async {
    final box = await Hive.openBox('BOX');
    await box.delete(key);
  }

  @override
  Future<T?> read<T>(String key) async {
    final box = await Hive.openBox('BOX');
    final existKey = box.containsKey('key');

    if (!existKey) return null;
    return box.get(key);
  }

  @override
  Future<void> update<T>(String key, T value) async {
    final box = await Hive.openBox('BOX');
    await box.put(key, value);
  }
}
