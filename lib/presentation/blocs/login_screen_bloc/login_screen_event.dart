part of 'login_screen_bloc.dart';

sealed class LoginScreenEvent {
  const LoginScreenEvent();
}

class EmailChangedEvent extends LoginScreenEvent {
  final String email;

  EmailChangedEvent({required this.email});
}

class PasswordChangedEvent extends LoginScreenEvent {
  final String password;

  PasswordChangedEvent({required this.password});
}

class SubmitEvent extends LoginScreenEvent {}

class LoadingEvent extends LoginScreenEvent {
  final bool isLoading;

  LoadingEvent({required this.isLoading});
}

class NavigationToHomeEvent extends LoginScreenEvent {}

class ErrorDataEvent extends LoginScreenEvent {
  final ErrorData errorData;

  ErrorDataEvent({required this.errorData});
}
