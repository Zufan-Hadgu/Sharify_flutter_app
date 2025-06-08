import 'package:dartz/dartz_streaming.dart';
import 'package:dartz/dartz_streaming.dart' as flutter;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../presentation/pages/admin/admin_home.dart';
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
    GoRoute(path: "/admin_home", builder: (context, state) =>  AdminDashboardScreen()),
    GoRoute(path: "/lending", builder: (context, state) =>  AdminLendingScreen()),
    GoRoute(path: "/profile", builder: (context, state) =>  ProfileScreen()),

    // ✅ Fixing Item Detail Route
    GoRoute(
      path: "/item-detail",
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>; // ✅ Extract data
        final id = extra["id"] as String;

        return ItemDetailPage(id: id);
      },
    ),
  ],
));