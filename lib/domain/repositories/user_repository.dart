import '../domain.dart';

abstract class UserRepository {

  Future<void> saveUsersFake();

  Future<UserView> login(String email, String password);

  Future<bool> isLoggedIn();

  Future<void> saveLoggedIn(bool isLoggedIn);
}