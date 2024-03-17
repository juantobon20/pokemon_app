import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:pokemon_app/domain/domain.dart';

part 'app_router_state.dart';

class AppRouterCubit extends Cubit<AppRouterState> with ChangeNotifier {

  final UserRepository _userRepository;
  AppRouterCubit({
    required UserRepository userRepository
  }) : _userRepository = userRepository,
   super(const AppRouterState()) {
    checkAuthStatus();
   }

  void checkAuthStatus() async {
    final bool isLoading = await _userRepository.isLoggedIn();
    late AuthStatus authStatus;
    if (isLoading) {
      authStatus = AuthStatus.authenticated;
    } else {
      authStatus = AuthStatus.notAuthenticated;
    }

    emit(
      state.copyWith(
        authStatus: authStatus
      )
    );
  }

  void logOut() async {
    await _userRepository.saveLoggedIn(false);

    checkAuthStatus();
  }
}
