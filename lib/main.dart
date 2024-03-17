import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/config/config.dart';
import 'package:pokemon_app/data/data.dart';
import 'package:pokemon_app/domain/domain.dart';

import 'presentation/blocs/bloc.dart';

void main() {
  final UserRepository userRepository = UserRepositoryImpl(
    userDatasource: UserDatasourceImpl(
      keyValueStorageService: KeyValueStorageServiceImpl()
    )
  );

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create:(context) => AppRouterCubit(userRepository: userRepository)),
      BlocProvider(create: (context) => LoginScreenBloc(userRepository: userRepository)),
    ],
    child: const MainApp()
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter().routes(context.watch<AppRouterCubit>()),
      theme: AppTheme().getTheme(),
      debugShowCheckedModeBanner: false,
    );
  }
}
