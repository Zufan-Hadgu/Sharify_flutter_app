import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../auth/base_screen.dart';

class UserBorrowingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      role: "user",
      currentRoute: '/borrowing',
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_cart, size: 60, color: Colors.green),
            SizedBox(height: 20),
            Text(
              "Borrowing History",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            // Example list item
            Card(
              child: ListTile(
                leading: Icon(Icons.book),
                title: Text("Book: Flutter Guide"),
                subtitle: Text("Due: 2023-12-01"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}