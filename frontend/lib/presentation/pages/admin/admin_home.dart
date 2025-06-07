import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../auth/base_screen.dart';

class AdminDashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      role: "admin",
      currentRoute: '/admin_home',
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.dashboard, size: 60, color: Colors.purple),
            SizedBox(height: 20),
            Text(
              "Admin Dashboard",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "Manage your lending system",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 20),
            // Quick stats example
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatCard("Active Loans", "12", Colors.blue),
                _buildStatCard("Overdue", "3", Colors.orange),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, Color color) {
    return Card(
      color: color.withOpacity(0.1),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(title, style: TextStyle(color: color)),
          ],
        ),
      ),
    );
  }
}