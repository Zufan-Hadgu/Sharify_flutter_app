import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sharify_flutter_app/presentation/widgets/auth/login_form.dart';
import '../../providers/auth/auth_notifier.dart';


class LoginPage extends ConsumerWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authNotifier = ref.watch(authNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LoginForm(
          onSubmit: (email, password) {
            authNotifier.login(email, password);
          },
        ),
      ),
    );
  }
}