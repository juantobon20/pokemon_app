abstract class KeyValueStorageService {

  Future<void> setKeyValue<T>(String key, T value, bool isEncrypted);

  Future<T?> getValue<T>(String key, bool isEncrypted);
}