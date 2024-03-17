import '../../data/data.dart';

abstract class UserDatasource {

  Future<UserPreferences> login(String email, String password);

  Future<void> saveUsersFake();

  Future<bool> isLoggedIn();

  Future<void> saveLoggedIn(bool isLoggedIn);
}