part of 'login_screen_bloc.dart';

class LoginScreenState extends Equatable {

  final bool isLoading;
  final bool isValid;
  final bool isFormPosted;
  final Email email;
  final Password password;
  final ErrorData? errorData;
  final bool navigateToHome;

  const LoginScreenState({
    this.isLoading = false,
    this.isValid = false, 
    this.isFormPosted = false,
    this.email = const Email.pure(), 
    this.password = const Password.pure(),
    this.errorData,
    this.navigateToHome = false
  });

  LoginScreenState copyWith({
    bool? isLoading,
    bool? isValid,
    bool? isFormPosted,
    Email? email,
    Password? password,
    ErrorData? errorData,
    bool? navigateToHome
  }) => LoginScreenState(
    isLoading: isLoading ?? this.isLoading,
    isValid: isValid ?? this.isValid,
    isFormPosted: isFormPosted ?? this.isFormPosted,
    email: email ?? this.email,
    password: password ?? this.password,
    errorData: errorData,
    navigateToHome: navigateToHome ?? this.navigateToHome
  );

  @override
  List<Object> get props => [isLoading, isValid, isFormPosted, email, password];
}