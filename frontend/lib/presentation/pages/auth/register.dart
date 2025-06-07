import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../providers/auth/auth_notifier.dart';
import '../../widgets/auth/auth_form.dart';

class RegisterPage extends ConsumerWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authNotifier = ref.watch(authNotifierProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Create an Account",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "Hello! Let's get started.",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 40),

            AuthForm(
              onSubmit: (name, email, password) {
                authNotifier.register(name, email, password);
              },
            ),

            const SizedBox(height: 20),


            GestureDetector(
              onTap: () => context.go('/login'),
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                  children: [
                    const TextSpan(text: "Already registered? "),
                    TextSpan(
                      text: "Sign In",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF005D73),  // ✅ Styled "Sign In"
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}