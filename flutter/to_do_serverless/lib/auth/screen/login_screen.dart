import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_serverless/auth/logic/firebase_auth_service.dart';
import 'package:to_do_serverless/auth/screen/sign_up_screen.dart';
import 'package:to_do_serverless/to_do_list/screens/to_do_list_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          _buildLoginLabel(),
          const SizedBox(
            height: 32.0,
          ),
          _buildLoginTextField(),
          const SizedBox(
            height: 16.0,
          ),
          _buildPasswordTextField(),
          const SizedBox(
            height: 16.0,
          ),
          _buildLoginButton(context),
          _buildSignUpButton(context)
        ]),
      )),
    );
  }

  Widget _buildLoginLabel() {
    return const Text(
      'Log in',
      style: TextStyle(fontSize: 24),
    );
  }

  Widget _buildLoginTextField() {
    return TextField(
      controller: _emailController,
      decoration: const InputDecoration(
        labelText: 'Name',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              10,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordTextField() {
    return TextField(
      controller: _passwordController,
      obscureText: true,
      decoration: const InputDecoration(
        labelText: 'Password',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              10,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _login(context),
      child: const Text(
        'Log in',
      ),
    );
  }

  void _login(BuildContext context) async {
    try {
      await FirebaseAuthService.logIn(
        email: _emailController.text,
        password: _passwordController.text,
      );
      // Navigate to the to do list screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ToDoListScreen(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message ?? 'Error'),
        ),
      );
    }
  }

  Widget _buildSignUpButton(BuildContext context) {
    return TextButton(
        onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const SignUpScreen(),
              ),
            ),
        child: const Text(
          "Don't have an account? Sing up",
          style: TextStyle(
            decoration: TextDecoration.underline,
            color: Colors.black,
          ),
        ));
  }
}
