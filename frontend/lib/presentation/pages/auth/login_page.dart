import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../providers/auth/auth_notifier.dart';
import '../../providers/auth/auth_state.dart';
import '../../widgets/auth/login_form.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authNotifier = ref.watch(authNotifierProvider.notifier);
    final authState = ref.watch(authNotifierProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => context.go('/register'), // ✅ Navigation back to register
          icon: const Icon(Icons.arrow_back, color: Colors.black), // ✅ Back button at the top
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Login",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 60),

            LoginForm(
              onSubmit: (email, password) {
                authNotifier.login(email, password);
              },
            ),

            const SizedBox(height: 40),

            authState.maybeWhen(
              error: (message) => Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  message,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
              orElse: () => const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}