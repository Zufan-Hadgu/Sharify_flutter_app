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
          mainAxisAlignment: MainAxisAlignment.center, // ✅ Center content vertically
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center, // ✅ Center text & image
              children: [
                Image.asset("assets/images/landing_page.png", height: 200),  // Your image
                const SizedBox(height: 20),
                const Text(
                  "SHARIFY",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center, // ✅ Center text
                ),
                const SizedBox(height: 10),
                const Text(
                  "Join our vibrant sharing community today",
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF005D73),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () => context.go('/register'),
                child: const Text("Get Started", style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}