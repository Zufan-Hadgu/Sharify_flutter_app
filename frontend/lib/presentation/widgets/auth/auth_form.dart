import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(String name, String email, String password) onSubmit;

  const AuthForm({Key? key, required this.onSubmit}) : super(key: key);

  @override
  _AuthFormState createState() => _AuthFormState();
}
class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _submit() {
    if (_formKey.currentState!.validate()) {
      widget.onSubmit(
        nameController.text,
        emailController.text,
        passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: nameController,
            decoration: const InputDecoration(labelText: "Name"),
          ),
          TextFormField(
            controller: emailController,
            decoration: const InputDecoration(labelText: "Email"),
          ),
          TextFormField(
            controller: passwordController,
            decoration: const InputDecoration(labelText: "Password"),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _submit,
            child: const Text("Register"),
          ),
        ],
      ),
    );
  }
}