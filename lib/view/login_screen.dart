import 'package:chat_app/components/button_widget.dart';
import 'package:chat_app/components/textfields_widget.dart';
import 'package:chat_app/services/auth/auth_services.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  void Function()? onTap;
  LoginScreen({super.key, required this.onTap});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.message,
            size: 60,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 50),
          Text(
            "Welcome back, you've been missed!",
            style: TextStyle(
                fontSize: 16, color: Theme.of(context).colorScheme.primary),
          ),
          const SizedBox(height: 25),
          TextFieldWidget(
            hintText: 'Email',
            obscureText: false,
            controller: _emailController,
          ),
          const SizedBox(height: 10),
          TextFieldWidget(
            hintText: 'Password',
            obscureText: true,
            controller: _passwordController,
          ),
          ButtonWidget(
            onTap: () => login(context),
            text: 'Login',
          ),
          const SizedBox(height: 25),
          Row(
            children: [
              Text(
                "Not a member?",
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              GestureDetector(
                onTap: onTap,
                child: const Text(
                  "Register now",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void login(BuildContext context) async {
    final authService = AuthServices();

    try {
      await authService.signInWithEmailPassword(
          _emailController.text, _passwordController.text);
    } catch (e) {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(e.toString()),
        ),
      );
    }
  }
}
