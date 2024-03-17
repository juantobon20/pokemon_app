import 'package:secure_shared_preferences/secure_shared_preferences.dart';

import 'key_value_storage_services.dart';

class KeyValueStorageServiceImpl implements KeyValueStorageService {

  Future<SecureSharedPref> getSharedPrefs() async {
    return await SecureSharedPref.getInstance();
  }

  @override
  Future<T?> getValue<T>(String key, bool isEncrypted) async {
    final prefs = await getSharedPrefs();
    
    switch(T) {
      case int:
        return await prefs.getInt(key, isEncrypted: isEncrypted) as T?;
      case bool:
        return await prefs.getBool(key, isEncrypted: isEncrypted) as T?;
      case String:
        return await prefs.getString(key, isEncrypted: isEncrypted) as T?;
      default:
        throw UnimplementedError('Set not implemented for type ${T.runtimeType}');
    }
  }

  @override
  Future<void> setKeyValue<T>(String key, T value, bool isEncrypted) async {
    final prefs = await getSharedPrefs();

    switch(T) {
      case int:
        await prefs.putInt(key, value as int, isEncrypted: isEncrypted);
        break;
      case bool:
        await prefs.putBool(key, value as bool, isEncrypted: isEncrypted);
        break;
      case String:
        await prefs.putString(key, value as String, isEncrypted: isEncrypted);
        break;
      default:
        throw UnimplementedError('Set not implemented for type ${T.runtimeType}');
    }
  }

}