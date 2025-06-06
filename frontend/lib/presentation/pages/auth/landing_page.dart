import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GettingStarted extends StatelessWidget {
  const GettingStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/landing_page.png", height: 200),  // Your image
                const SizedBox(height: 20),
                const Text("SHARIFY", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                const Text("Join our vibrant sharing community today", style: TextStyle(fontSize: 16)),
              ],
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => context.go('/register'),  // ✅ Navigation 2.0
                child: const Text("Get Started"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}