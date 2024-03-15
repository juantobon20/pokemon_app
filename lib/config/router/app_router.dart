import 'package:go_router/go_router.dart';
import 'package:pokemon_app/presentation/screens/screen.dart';

final appRouter = GoRouter(
  initialLocation: loginPath,
  routes: [
    GoRoute(
      path: loginPath,
      builder:(_, __) => const LoginScreen(),
    ),

    GoRoute(
      path: homePath,
      builder: (_, __) => const HomeScreen()
    ),

    GoRoute(
      path: '/',
      redirect: (_, __) => '/home',
    )
  ]
);

const loginPath = '/login';
const homePath = '/:page';

const homeViewPath = "home";
const favoriteViewPath = "favorites";