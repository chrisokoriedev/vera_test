import 'package:flutter/material.dart';

import 'auth_widgets.dart';


class AuthSelectionScreen extends StatelessWidget {
  const AuthSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Image.asset(
            "assets/images/Logistics.jpg",
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.55,
            fit: BoxFit.cover,

          ),
          // Overlay Content
          Align(
            alignment:Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.50,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFF6FBFF),
                    Color(0xFFDCEBFF),
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Welcome to VeriConnect",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
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
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    const SizedBox(height: 10),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: SignInOptions(
                            onTap: (){},
                            imagePath: "assets/images/google (2).png",
                            text: "Google",
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: SignInOptions(
                            onTap: (){},
                            imagePath: "assets/images/apple 3.png",
                            text: "Apple",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
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
