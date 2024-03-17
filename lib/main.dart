import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/config/config.dart';

import 'data/data.dart';
import 'domain/domain.dart';
import 'presentation/blocs/bloc.dart';

final UserRepository userRepository = UserRepositoryImpl(
  userDatasource: UserDatasourceImpl(
    keyValueStorageService: KeyValueStorageServiceImpl()
  )
);

final PokemonRepository pokemonRepository = PokemonRepositoryImpl(
  pokemonDatasource: PokemonDatasourceImpl(
    dioProvider: DioProvider()
  )
);
  
void main() {

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create:(_) => AppRouterCubit(userRepository: userRepository)),
      BlocProvider(create: (_) => FavoriteViewCubit(pokemonRepository: pokemonRepository))
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
