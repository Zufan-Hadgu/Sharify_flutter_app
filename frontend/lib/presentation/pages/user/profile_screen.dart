import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../auth/base_screen.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      role: "user", // or "admin" - adjust dynamically if needed
      currentRoute: '/profile',
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage("https://example.com/profile.jpg"),
            ),
            SizedBox(height: 20),
            Text(
              "John Doe",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "john.doe@example.com",
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 30),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Log Out"),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}