import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_serverless/auth/logic/firebase_auth_service.dart';
import 'package:to_do_serverless/auth/screen/login_screen.dart';
import 'package:to_do_serverless/to_do_list/screens/to_do_list_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

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
          _buildNameTextField(),
          const SizedBox(
            height: 16.0,
          ),
          _buildEmailTextField(),
          const SizedBox(
            height: 16.0,
          ),
          _buildPasswordTextField(),
          const SizedBox(
            height: 16.0,
          ),
          _buildSignUpButton(context),
          _buildLoginButton(context)
        ]),
      )),
    );
  }

  Widget _buildLoginLabel() {
    return const Text(
      'Sign up',
      style: TextStyle(fontSize: 24),
    );
  }

  Widget _buildNameTextField() {
    return TextField(
      controller: _nameController,
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

  Widget _buildEmailTextField() {
    return TextField(
      controller: _emailController,
      decoration: const InputDecoration(
        labelText: 'Email',
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

  Widget _buildSignUpButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _signUp(context),
      child: const Text(
        'Sign up',
      ),
    );
  }

  void _signUp(BuildContext context) async {
    try {
      await FirebaseAuthService.signUp(
        email: _emailController.text,
        password: _passwordController.text,
        name: _nameController.text,
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

  Widget _buildLoginButton(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      ),
      child: const Text(
        "Do you already have an account? Log in",
        style: TextStyle(
          decoration: TextDecoration.underline,
          color: Colors.black,
        ),
      ),
    );
  }
}
