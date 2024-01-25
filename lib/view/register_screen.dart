import 'package:chat_app/components/button_widget.dart';
import 'package:chat_app/components/textfields_widget.dart';
import 'package:chat_app/services/auth/auth_services.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  final void Function()? onTap;
  RegisterScreen({super.key, required this.onTap});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

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
            "Let's create an account for you",
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
          const SizedBox(height: 10),
          TextFieldWidget(
            hintText: 'Confirm Password',
            obscureText: true,
            controller: _confirmPasswordController,
          ),
          ButtonWidget(
            onTap: () => register(context),
            text: 'Register',
          ),
          const SizedBox(height: 25),
          Row(
            children: [
              Text(
                "Already have an account",
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              GestureDetector(
                onTap: onTap,
                child: const Text(
                  "Login now",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void register(BuildContext context) {
    final auth = AuthServices();
    if (_passwordController.text == _confirmPasswordController.text) {
      try {
        auth.signUpWithEmailPassword(
          _emailController.text,
          _passwordController.text,
        );
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(e.toString()),
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text("Password don't match!"),
        ),
      );
    }
  }
}
