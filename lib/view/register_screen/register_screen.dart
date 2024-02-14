import 'package:chat_app/constants/sizedbox.dart';
import 'package:chat_app/services/auth/auth_services.dart';
import 'package:chat_app/widgets/button_widget.dart';
import 'package:chat_app/widgets/textfields_widget.dart';
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
          cHeight50,
          Text(
            "Let's create an account for you",
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
          cHeight10,
          TextFieldWidget(
            hintText: 'Confirm Password',
            obscureText: true,
            controller: _confirmPasswordController,
          ),
          cHeight25,
          ButtonWidget(
            onTap: () => register(context),
            text: 'Register',
          ),
          cHeight25,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already have an account?  ",
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              GestureDetector(
                onTap: onTap,
                child: Text(
                  "Login now",
                  style: TextStyle(fontWeight: FontWeight.bold,color: Theme.of(context).colorScheme.primary),
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
