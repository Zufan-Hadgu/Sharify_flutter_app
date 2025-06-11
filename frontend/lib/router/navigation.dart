import 'package:dartz/dartz_streaming.dart';
import 'package:dartz/dartz_streaming.dart' as flutter;


import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sharify_flutter_app/presentation/pages/admin/admin_profile.dart';
import 'package:sharify_flutter_app/presentation/pages/user/borrowing_screen.dart';

import '../presentation/pages/admin/admin_home.dart';
import '../presentation/pages/admin/admin_lend_form_screen.dart';
import '../presentation/pages/admin/admin_lending_screen.dart';
import '../presentation/pages/admin/lending_screen.dart';
import '../presentation/pages/auth/landing_page.dart';
import '../presentation/pages/auth/login_page.dart';
import '../presentation/pages/auth/register.dart';
import '../presentation/pages/user/item_detail_page.dart';
import '../presentation/pages/user/profile_screen.dart';
import '../presentation/pages/user/user_home.dart';

final goRouterProvider = Provider((ref) => GoRouter(
  initialLocation: "/get_started",
  routes: [
    GoRoute(path: "/get_started", builder: (context, state) => const GettingStarted()),
    GoRoute(path: "/login", builder: (context, state) => const LoginPage()),
    GoRoute(path: "/register", builder: (context, state) => const RegisterPage()),
    GoRoute(path: "/user_home", builder: (context, state) =>  UserHomePage()),
    GoRoute(path: "/admin_home", builder: (context, state) =>  AdminHomePage()),
    GoRoute(path: "/admin-profile", builder: (context, state) =>  AdminProfileScreen()),
    GoRoute(path: "/profile", builder: (context, state) =>  ProfileScreen()),
    GoRoute(path: "/borrowing", builder: (context, state) =>  UserBorrowingScreen()),
    GoRoute(path: "/item-detail", builder: (context, state) {
      final extra = state.extra as Map<String, dynamic>?;
      final id = extra?["id"] as String;
      return ItemDetailPage(id: id);
    },
    ),
    GoRoute(
      path: "/lending",
      builder: (context, state) => AdminLendingScreen(
        onAddItemClick: () {
          // ✅ Navigate to the item addition form
          context.go("/add_item");
        },
      ),
    ),
    GoRoute(
      path: "/add_item",
      builder: (context, state) => AdminLendingForm(
        onSubmit: () => print("✅ Item submitted!"),


      ),
    ),

  ],
));