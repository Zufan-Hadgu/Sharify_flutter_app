import 'package:flutter/material.dart';
import '../auth/base_screen.dart';

class UserHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      role: "user",
      currentRoute: '/user_home',
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.home, size: 60, color: Colors.blue),
            SizedBox(height: 20),
            Text(
              "Welcome, User!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "Start borrowing items today!",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}