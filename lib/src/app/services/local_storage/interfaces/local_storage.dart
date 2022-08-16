abstract class ILocalStorage<T> {
  Future<void> add(String key, T value);
  Future<T?> read(String key);
  Future<void> update(String key, T value);
  Future<void> delete(String key);
}
