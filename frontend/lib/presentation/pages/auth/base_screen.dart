import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BaseScreen extends StatelessWidget {
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
        case '/admin_home':
          return "Dashboard";
        case '/lending':
          return "Lending";
        case '/profile':
          return "Profile";
        default:
          return "Sharify";
      }
    } else {
      switch (currentRoute) {
        case '/user_home':
          return "Home";
        case '/borrowing':
          return "Borrowing";
        case '/profile':
          return "Profile";
        default:
          return "Sharify";
      }
    }
  }

  // Determine the selected bottom nav index
  int _getCurrentIndex() {
    if (role == "admin") {
      switch (currentRoute) {
        case '/admin_home':
          return 0;
        case '/lending':
          return 1;
        case '/profile':
          return 2;
        default:
          return 0;
      }
    } else {
      switch (currentRoute) {
        case '/user_home':
          return 0;
        case '/borrowing':
          return 1;
        case '/profile':
          return 2;
        default:
          return 0;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey.shade300, width: 1),
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            automaticallyImplyLeading: false,
            title: Text(
              _getAppBarTitle(),
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Row(
                  children: [
                    // ✅ Always show profile icon (EXCEPT on the profile screen for users)
                    if (role == "admin" || currentRoute != "/profile")
                      GestureDetector(
                        onTap: () => context.go('/profile'),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.grey[300],
                          child: const Icon(Icons.person, color: Colors.grey),
                        ),
                      ),

                    // ✅ Show three dots (`more_vert`) ONLY when user (not admin) is on profile screen
                    if (role != "admin" && currentRoute == "/profile")
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: IconButton(
                          icon: const Icon(Icons.more_vert, color: Colors.grey),
                          onPressed: () => _showOptionsDialog(context),
                        ),
                      ),

                    // ✅ Show logout icon ONLY when admin is on profile screen
                    if (role == "admin" && currentRoute == "/profile")
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: IconButton(
                          icon: const Icon(Icons.logout, color: Colors.grey),
                          onPressed: () => _showLogoutDialog(context),
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
              case 0:
                context.go('/admin_home');
                break;
              case 1:
                context.go('/lending');
                break;
              case 2:
                context.go('/profile');
                break;
            }
          } else {
            switch (index) {
              case 0:
                context.go('/user_home');
                break;
              case 1:
                context.go('/borrowing');
                break;
              case 2:
                context.go('/profile');
                break;
            }
          }
        },
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirm Logout"),
        content: const Text("Are you sure you want to log out?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () {
              // ✅ Implement logout logic here
              Navigator.pop(context);
            },
            child: const Text("Logout"),
          ),
        ],
      ),
    );
  }

  void _showOptionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Account Options"),
        content: const Text("Choose an action:"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () {
              // ✅ Implement logout logic
              Navigator.pop(context);
            },
            child: const Text("Logout"),
          ),
          ElevatedButton(
            onPressed: () {
              // ✅ Implement account deletion logic
              Navigator.pop(context);
            },
            child: const Text("Delete Account"),
          ),
        ],
      ),
    );
  }
}
