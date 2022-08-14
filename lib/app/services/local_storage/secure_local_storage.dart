import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:authentication_and_authorization_frontend/app/services/local_storage/interfaces/local_storage.dart';

class SecureLocalStorage implements ILocalStorage {
  @override
  Future<void> add<T>(String key, T value) async {
    const storage = FlutterSecureStorage();
    await storage.write(key: key, value: value.toString());
  }

  @override
  Future<void> delete(String key) async {
    const storage = FlutterSecureStorage();
    await storage.delete(key: key);
  }

  @override
  Future<T?> read<T>(String key) async {
    const storage = FlutterSecureStorage();
    return storage.read(key: key) as T;
  }

  @override
  Future<void> update<T>(String key, T value) async {
    const storage = FlutterSecureStorage();
    await storage.write(key: key, value: value.toString());
  }
}
