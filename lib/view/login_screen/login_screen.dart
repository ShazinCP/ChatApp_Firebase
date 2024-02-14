import 'package:chat_app/constants/sizedbox.dart';
import 'package:chat_app/services/auth/auth_services.dart';
import 'package:chat_app/widgets/button_widget.dart';
import 'package:chat_app/widgets/textfields_widget.dart';
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
          cHeight50,
          Text(
            "Welcome back, you've been missed!",
            style: TextStyle(
                fontSize: 16, color: Theme.of(context).colorScheme.primary),
          ),
          cHeight25,
          TextFieldWidget(
            hintText: 'Email',
            obscureText: false,
            controller: _emailController,
          ),
          cHeight10,
          TextFieldWidget(
            hintText: 'Password',
            obscureText: true,
            controller: _passwordController,
          ),
          cHeight25,
          ButtonWidget(
            onTap: () => login(context),
            text: 'Login',
          ),
          cHeight25,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Not a member?  ",
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              GestureDetector(
                onTap: onTap,
                child: Text(
                  "Register now",
                  style: TextStyle(fontWeight: FontWeight.bold,color: Theme.of(context).colorScheme.primary),
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
