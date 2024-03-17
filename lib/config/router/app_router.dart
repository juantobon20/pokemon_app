import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pokemon_app/main.dart';

import '../../data/data.dart';
import '../../presentation/blocs/bloc.dart';
import '../../presentation/screens/screen.dart';
import 'app_router_cubit/app_router_cubit.dart';

class AppRouter {
  GoRouter routes(AppRouterCubit routerCubit) {
    return GoRouter(
      initialLocation: loginPath,
      routes: [
        GoRoute(
          path: loginPath,
          builder: (_, __) => BlocProvider(
            create: (context) => LoginScreenBloc(
              userRepository: userRepository
            ),
            child: const LoginScreen(),
          ),
        ),
        GoRoute(
            path: homePath,
            builder: (_, __) => BlocProvider(
                  create: (context) => HomeCubit(
                      pokemonRepository: PokemonRepositoryImpl(
                          pokemonDatasource: PokemonDatasourceImpl())),
                  child: const HomeScreen(),
                ),
            routes: [
              GoRoute(
                  path: pokemonDetailPath,
                  builder: (_, state) {
                    final pokemonId = int.tryParse(state.params['id'] ?? '-1') ?? -1;
                    return BlocProvider(
                      create: (_) => PokemonDetailScreenCubit(
                          pokemonRepository: PokemonRepositoryImpl(
                              pokemonDatasource: PokemonDatasourceImpl())),
                      child: PokemonDetailScreen(pokemonId: pokemonId),
                    );
                  }),
            ]),
        GoRoute(
          path: '/',
          redirect: (_, __) => '/home',
        )
      ],
      redirect: (context, state) {
        final isGoingTo = state.subloc;
        final AuthStatus authStatus = routerCubit.state.authStatus;

        if (isGoingTo == loginPath && authStatus == AuthStatus.checking) {
          return null;
        }

        if (authStatus == AuthStatus.notAuthenticated) {
          if (isGoingTo == loginPath) {
            return null;
          }

          return loginPath;
        }

        if (authStatus == AuthStatus.authenticated) {
          if (isGoingTo == loginPath) {
            return homePath;
          }
        }

        return null;
      },
    );
  }
}

const loginPath = '/login';
const homePath = '/:page';
const pokemonDetailPath = 'pokemon_detail/:id';

const homeViewPath = "home";
const favoriteViewPath = "favorites";
