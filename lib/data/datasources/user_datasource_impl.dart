import 'dart:convert';

import '../../domain/domain.dart';
import '../data.dart';

class UserDatasourceImpl implements UserDatasource {

  final KeyValueStorageService _keyValueStorageService;

  UserDatasourceImpl({
    required KeyValueStorageService keyValueStorageService
  }) : _keyValueStorageService = keyValueStorageService;

  @override
  Future<UserPreferences> login(String email, String password) async {
    final String? usersFakeJson = await _keyValueStorageService.getValue<String>(usersFakeKey, true);
    if (usersFakeJson == null || usersFakeJson.isEmpty) {
      throw SharedPreferencesDataException();
    }
    final List<UserPreferences> usersFake = List<UserPreferences>.from(jsonDecode(usersFakeJson).map((e) => UserPreferences.fromJson(e)));
    if (usersFake.isEmpty) {
      throw SharedPreferencesDataException();
    }
  
    for (var user in usersFake) {
      if (user.email == email) {
        if (user.password != password) {
          throw UserDataException(message: 'Contraseña incorrecta');
        }
        return user;
      }
    }

    throw UserDataException(message: 'Usuario no registrado');
  }

  @override
  Future<void> saveUsersFake() async {
    final String? usersJson = await _keyValueStorageService.getValue<String>(usersFakeKey, true);
    if (usersJson == null) {
      final usersFakeJson = usersFake.map((e) => e.toJson()).toList();
      final String usersStringJson = jsonEncode(usersFakeJson);
      await _keyValueStorageService.setKeyValue<String>(usersFakeKey, usersStringJson, true);
    }
  }
  
  @override
  Future<bool> isLoggedIn() async {
    final bool? isLoggedIn = await _keyValueStorageService.getValue<bool>(isLoggedInKey, true);
    return isLoggedIn ?? false;
  }
  
  @override
  Future<void> saveLoggedIn(bool isLoggedIn) async {
    await _keyValueStorageService.setKeyValue(isLoggedInKey, isLoggedIn, true);
  }
}

const String usersFakeKey = 'USERS_FAKE_KEY'; 
const String isLoggedInKey = 'LOGGED_IN_KEY'; 