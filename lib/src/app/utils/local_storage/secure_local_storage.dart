import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:authentication_and_authorization_frontend/src/app/utils/local_storage/interfaces/local_storage.dart';

class SecureLocalStorage implements ILocalStorage {
  final FlutterSecureStorage _secureStorage;

  SecureLocalStorage(this._secureStorage);

  @override
  Future<void> add<T>(String key, T value) async {
    await _secureStorage.write(key: key, value: value.toString());
  }

  @override
  Future<void> delete(String key) async {
    await _secureStorage.delete(key: key);
  }

  @override
  Future<T?> read<T>(String key) async {
    return _secureStorage.read(key: key) as T;
  }

  @override
  Future<void> update<T>(String key, T value) async {
    await _secureStorage.write(key: key, value: value.toString());
  }
}
