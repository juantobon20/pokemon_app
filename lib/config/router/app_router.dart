import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../data/data.dart';
import '../../presentation/blocs/bloc.dart';
import '../../presentation/screens/screen.dart';

final appRouter = GoRouter(
  initialLocation: loginPath, 
  routes: [
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
      ),
      routes: [
        GoRoute(
          path: pokemonDetailPath,
          builder: (_, state) {
            final pokemonId = int.tryParse(state.pathParameters['id'] ?? '1') ?? 1;
            return BlocProvider(
              create: (_) => PokemonDetailScreenCubit(
                pokemonRepository: PokemonRepositoryImpl(
                  pokemonDatasource: PokemonDatasourceImpl()
                )
              ),
              child: PokemonDetailScreen(pokemonId: pokemonId),
            );
          }
        ),  
      ]
    ),

    GoRoute(
      path: '/',
      redirect: (_, __) => '/home',
    )
  ]
);

const loginPath = '/login';
const homePath = '/:page';
const pokemonDetailPath = 'pokemon_detail/:id';

const homeViewPath = "home";
const favoriteViewPath = "favorites";
