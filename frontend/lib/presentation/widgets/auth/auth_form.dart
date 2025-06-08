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
          _buildTextField(nameController, "Name", Icons.person),
          const SizedBox(height: 10),
          _buildTextField(emailController, "Email", Icons.email),
          const SizedBox(height: 10),
          _buildTextField(passwordController, "Password", Icons.lock, isPassword: true),
          const SizedBox(height: 20),

          ElevatedButton(
            onPressed: _submit,
            child: const Text("Sign Up"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF005D73),
              minimumSize: const Size(double.infinity, 50),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon, {bool isPassword = false}) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(),
      ),
    );
  }
}