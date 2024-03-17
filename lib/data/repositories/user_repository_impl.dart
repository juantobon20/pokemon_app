import '../../domain/domain.dart';
import '../data.dart';

class UserRepositoryImpl implements UserRepository {

  final UserDatasource _userDatasource;

  UserRepositoryImpl({
    required UserDatasource userDatasource
  }) : _userDatasource = userDatasource;

  @override
  Future<UserView> login(email, password) async {
    final UserPreferences userPreferences = await _userDatasource.login(email, password);
    return userPreferences.mapper();
  }

  @override
  Future<void> saveUsersFake() => _userDatasource.saveUsersFake();
  
  @override
  Future<bool> isLoggedIn() => _userDatasource.isLoggedIn();
  
  @override
  Future<void> saveLoggedIn(bool isLoggedIn) => _userDatasource.saveLoggedIn(isLoggedIn);
}