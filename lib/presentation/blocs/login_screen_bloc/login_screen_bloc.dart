import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../domain/domain.dart';
import '../../widgets/widget.dart';

part 'login_screen_event.dart';
part 'login_screen_state.dart';

class LoginScreenBloc extends Bloc<LoginScreenEvent, LoginScreenState> {

  final UserRepository _userRepository;
  LoginScreenBloc({
    required UserRepository userRepository
  }) : _userRepository = userRepository,
      super(const LoginScreenState()) {
        on<EmailChangedEvent>(_onEmailChanged);
        on<PasswordChangedEvent>(_onPasswordChanged);
        on<SubmitEvent>(_touchEveryField);
        on<LoadingEvent>(_updateLoading);
        on<ErrorDataEvent>(_errorDataChanged);
        on<NavigationToHomeEvent>(_navigationToHome);

        _userRepository.saveUsersFake();
      }

  void _onEmailChanged(EmailChangedEvent event, Emitter<LoginScreenState> emit) {
    final Email newEmail = Email.dirty(event.email);

    emit(state.copyWith(
      email: newEmail,
      isValid: Formz.validate([newEmail, state.password])
    ));
  }

  void _onPasswordChanged(PasswordChangedEvent event, Emitter<LoginScreenState> emit) {
    final Password newPassword = Password.dirty(event.password);

    emit(state.copyWith(
      password: newPassword,
      isValid: Formz.validate([newPassword, state.email])
    ));
  }

  void _touchEveryField(SubmitEvent event, Emitter<LoginScreenState> emit) {
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);

    emit(state.copyWith(
      isFormPosted: true,
      email: email,
      password: password,
      isValid: Formz.validate([email, password])
    ));
  }

  void _updateLoading(LoadingEvent event, Emitter<LoginScreenState> emit) {
    emit(state.copyWith(
      isLoading: event.isLoading
    ));
  }

  void _errorDataChanged(ErrorDataEvent event, Emitter<LoginScreenState> emit) {  
    emit(state.copyWith(
      isLoading: false,
      errorData: event.errorData
    ));
  }

  void _navigationToHome(NavigationToHomeEvent event, Emitter<LoginScreenState> emit) {  
    emit(state.copyWith(
      isLoading: false,
      navigateToHome: true
    ));
  }

  void onEmailChanged(String value) {
    add(EmailChangedEvent(email: value));
  }

  void onPasswordChanged(String value) {
    add(PasswordChangedEvent(password: value));
  }

  void onFormSubmit() async {
    add(SubmitEvent());

    if (!state.isValid) {
      return;
    }

    add(LoadingEvent(isLoading: true));

    try {
      await _userRepository.login(state.email.value, state.password.value);
      _userRepository.saveLoggedIn(true);

      add(NavigationToHomeEvent());
    } on UserDataException catch (e) {
      _emitException(e.message);
    } on SharedPreferencesDataException catch (_) {
      _emitException('Error al obtener datos');
    } catch (e) {
      _emitException('Error no encontrado');
    }
  }

  void _emitException(String message) {
    add(ErrorDataEvent(errorData: ErrorData(
      errorType: ErrorType.loginError,
      errorMessage: message
    )));
  }
}
