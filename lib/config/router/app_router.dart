import 'package:go_router/go_router.dart';
import 'package:pokemon_app/presentation/screens/screen.dart';

final appRouter = GoRouter(
  initialLocation: loginPath,
  routes: [
    GoRoute(
      path: loginPath,
      builder:(context, state) => const LoginScreen(),
    )
  ]
);

const loginPath = '/';