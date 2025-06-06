import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sharify_flutter_app/presentation/pages/auth/landing_page.dart';

import '../presentation/pages/auth/login_page.dart';
import '../presentation/pages/auth/register.dart';

final goRouterProvider = Provider((ref) => GoRouter(
  initialLocation: "/get_started",
  routes: [
    GoRoute(path: "/get_started", builder: (context, state) => const GettingStarted()),
    GoRoute(path: "/login", builder: (context, state) => const LoginPage()),
    GoRoute(path: "/register", builder: (context, state) => const RegisterPage()),
    GoRoute(path: "/user_home", builder: (context, state) => const LoginPage()),
    GoRoute(path: "/admin_home", builder: (context, state) => const RegisterPage()),
  ],
));