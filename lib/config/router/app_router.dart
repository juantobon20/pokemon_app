import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:pokemon_app/data/data.dart';
import 'package:pokemon_app/presentation/screens/home/cubit/home_cubit.dart';
import 'package:pokemon_app/presentation/screens/screen.dart';

final appRouter = GoRouter(initialLocation: loginPath, routes: [
  GoRoute(
    path: loginPath,
    builder: (_, __) => const LoginScreen(),
  ),
  GoRoute(
      path: homePath,
      builder: (_, __) => BlocProvider(
            create: (context) => HomeCubit(
              pokemonRepository: PokemonRepositoryImpl(
                pokemonDatasource: PokemonDatasourceImpl()
              )
            ),
            child: const HomeScreen(),
          )),
  GoRoute(
    path: '/',
    redirect: (_, __) => '/home',
  )
]);

const loginPath = '/login';
const homePath = '/:page';

const homeViewPath = "home";
const favoriteViewPath = "favorites";
