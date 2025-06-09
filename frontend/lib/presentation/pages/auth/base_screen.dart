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
          return "Dashboard"; // ✅ Changed from "Admin Dashboard"
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
        preferredSize: Size.fromHeight(60),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey.shade300, width: 1), // ✅ Added grey bottom line
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            automaticallyImplyLeading: false,
            title: Text(
              _getAppBarTitle(),
              style: TextStyle(
                fontSize: 22, // ✅ Increased font size
                fontWeight: FontWeight.bold, // ✅ Made it bold
                color: Colors.black,
              ),
            ),
            actions: [
              // Profile avatar (top-right corner)
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: GestureDetector(
                  onTap: () => context.go('/profile'),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.grey[300],
                    child: Icon(Icons.person, color: Colors.grey[600]),
                    // Replace with user image if available:
                    // backgroundImage: NetworkImage(user.profilePicUrl),
                  ),
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
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: "Dashboard",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: "Lending",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ]
            : [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Borrowing",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
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
}
