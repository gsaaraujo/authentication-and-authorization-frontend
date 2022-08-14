abstract class ILocalStorage {
  Future<void> add<T>(String key, T value);
  Future<T?> read<T>(String key);
  Future<void> update<T>(String key, T value);
  Future<void> delete(String key);
}
