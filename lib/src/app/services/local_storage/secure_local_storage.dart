import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:authentication_and_authorization_frontend/src/app/services/local_storage/models/user_tokens.dart';
import 'package:authentication_and_authorization_frontend/src/app/services/local_storage/interfaces/local_storage.dart';

class SecureLocalStorage implements ILocalStorage<UserTokens> {
  final FlutterSecureStorage _secureStorage;

  SecureLocalStorage(this._secureStorage);

  @override
  Future<void> add(String key, UserTokens value) async {
    await _secureStorage.write(key: key, value: value.toJson());
  }

  @override
  Future<void> delete(String key) async {
    await _secureStorage.delete(key: key);
  }

  @override
  Future<UserTokens?> read(String key) async {
    final userTokens = await _secureStorage.read(key: key);
    if (userTokens == null) return null;
    return UserTokens.fromJson(userTokens);
  }

  @override
  Future<void> update(String key, UserTokens value) async {
    await _secureStorage.write(key: key, value: value.toJson());
  }
}
