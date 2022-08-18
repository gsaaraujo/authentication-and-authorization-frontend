import 'package:hive/hive.dart';
import 'package:authentication_and_authorization_frontend/src/app/services/local_storage/models/user_info.dart';
import 'package:authentication_and_authorization_frontend/src/app/services/local_storage/interfaces/local_storage.dart';

class UserLocalStorage implements ILocalStorage<UserInfo> {
  final HiveInterface _hive;

  UserLocalStorage(this._hive);

  @override
  Future<void> add(String key, UserInfo value) async {
    final box = await _hive.openBox('BOX');
    await box.put(key, value.toMap());
  }

  @override
  Future<void> delete(String key) async {
    final box = await _hive.openBox('BOX');
    await box.delete(key);
  }

  @override
  Future<UserInfo?> read(String key) async {
    final box = await _hive.openBox('BOX');
    final existKey = box.containsKey(key);

    if (!existKey) return null;

    final userInfo = box.get(key) as Map<String, dynamic>;
    return UserInfo.fromMap(userInfo);
  }

  @override
  Future<void> update(String key, UserInfo value) async {
    final box = await _hive.openBox('BOX');
    await box.put(key, value.toMap());
  }
}
