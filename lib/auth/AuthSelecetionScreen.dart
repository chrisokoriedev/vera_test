import 'package:flutter/material.dart';

import 'auth_widgets.dart';

class AuthSelectionScreen extends StatelessWidget {
  const AuthSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Top background Image
          ClipRRect(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(300)),
            child: Image.asset(
              "assets/images/Logistics.jpg",
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.5,
              fit: BoxFit.cover,
            ),
          ),

          // Content after the background image
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 300),
                  const Text(
                    "Welcome to VeriConnect",
                    style: TextStyle(fontSize: 30),
                  ),
                  const SizedBox(height: 10),
                  AuthButtons(
                    text: 'Log in',
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                  ),
                  const SizedBox(height: 15),
                  AuthButtons(
                    text: "Sign Up",
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/register');
                    },
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "Continue with Accounts",
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SignInOptions(icon: Icons.safety_check, text: "Google"),
                      SignInOptions(icon: Icons.safety_check, text: "Github"),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AuthButtons extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const AuthButtons({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
