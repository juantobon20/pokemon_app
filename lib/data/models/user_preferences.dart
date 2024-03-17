import 'package:pokemon_app/domain/domain.dart';

class UserPreferences {

  final String email;
  final String password;
  final String name;
  final bool isBlocked;

  UserPreferences({
    required this.email, 
    required this.password, 
    required this.name,
    this.isBlocked = false
  });

  Map<String, dynamic> toJson() => {
    'email' : email,
    'password' : password,
    'name' : name,
    'isBlocked' : isBlocked
  };

  factory UserPreferences.fromJson(Map<String, dynamic> json) => UserPreferences(
    email: json["email"],
    password: json["password"],
    name: json["name"],
    isBlocked: json["isBlocked"],
  );
}

final List<UserPreferences> usersFake = [
  UserPreferences(email: 'test1@google.com', password: 'abc123', name: 'Usuario de prueba 1'),
  UserPreferences(email: 'test2@google.com', password: 'abc123', name: 'Usuario de prueba 2', isBlocked: true),
];

extension UserMapper on UserPreferences {

  UserView mapper() => UserView(
    name: name
  );
}