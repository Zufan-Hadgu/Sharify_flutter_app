import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../core/provider/provider.dart';
import '../../widgets/user/option_dialog.dart';
import '../../widgets/user/show_logout_dialog.dart';

class BaseScreen extends ConsumerWidget {
  final Widget child;
  final String role;
  final String currentRoute;

  const BaseScreen({
    required this.child,
    required this.role,
    required this.currentRoute,
    super.key,
  });

  // Map routes to their display titles
  String _getAppBarTitle() {
    if (role == "admin") {
      switch (currentRoute) {
        case '/admin_home': return "Dashboard";
        case '/lending': return "Lending";
        case '/admin-profile': return "Admin Profile";
        default: return "Sharify";
      }
    } else {
      switch (currentRoute) {
        case '/user_home': return "Home";
        case '/borrowing': return "Borrowing";
        case '/profile': return "Profile";
        default: return "Sharify";
      }
    }
  }

  int _getCurrentIndex() {
    if (role == "admin") {
      switch (currentRoute) {
        case '/admin_home': return 0;
        case '/lending': return 1;
        case '/admin-profile': return 2;
        default: return 0;
      }
    } else {
      switch (currentRoute) {
        case '/user_home': return 0;
        case '/borrowing': return 1;
        case '/profile': return 2;
        default: return 0;
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Container(
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey.shade300, width: 1)),
          ),
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            automaticallyImplyLeading: false,
            title: Text(
              _getAppBarTitle(),
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Row(
                  children: [
                    if (role == "admin" && currentRoute != "/admin-profile") // ✅ Hide when on profile
                      GestureDetector(
                        onTap: () => context.go('/admin-profile'),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.grey[300],
                          child: const Icon(Icons.person, color: Colors.grey),
                        ),
                      ),

                    if (role != "admin" && currentRoute != "/profile") // ✅ Hide when on profile
                      GestureDetector(
                        onTap: () => context.go('/profile'),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.grey[300],
                          child: const Icon(Icons.person, color: Colors.grey),
                        ),
                      ),

                    if (role != "admin" && currentRoute == "/profile")
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: IconButton(
                          icon: const Icon(Icons.more_vert, color: Colors.grey),
                          onPressed: () => showOptionDialog(context, ref),
                        ),
                      ),

                    if (role == "admin" && currentRoute == "/admin-profile")
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: IconButton(
                          icon: const Icon(Icons.logout, color: Colors.grey),
                          onPressed: () => showLogoutDialog(context, ref),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _getCurrentIndex(),
        items: role == "admin"
            ? [
          const BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Dashboard"),
          const BottomNavigationBarItem(icon: Icon(Icons.library_books), label: "Lending"),
          const BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ]
            : [
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          const BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Borrowing"),
          const BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
        onTap: (index) {
          if (role == "admin") {
            switch (index) {
              case 0: context.go('/admin_home'); break;
              case 1: context.go('/lending'); break;
              case 2: context.go('/admin-profile'); break; // ✅ Ensure admin goes to `/admin-profile`
            }
          } else {
            switch (index) {
              case 0: context.go('/user_home'); break;
              case 1: context.go('/borrowing'); break;
              case 2: context.go('/profile'); break;
            }
          }
        },
      ),
    );
  }










}