import 'package:flutter/material.dart';
import 'package:vericon/auth/auth_widgets.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(250),
            ),
            child: Image.asset(
              "assets/images/Logistics.jpg",
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.3,
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 200,),
                  Text("Create Your Account", style: TextStyle(fontSize: 30)),
                  SizedBox(height: 20),
                  MyCustomTextField(
                    controller: fullNameController,
                    hintText: "Enter full name",
                    prefixIcon: Icons.person,
                  ),
                  SizedBox(height: 20),
                  MyCustomTextField(
                    controller: emailController,
                    hintText: "Enter email",
                    prefixIcon: Icons.email,
                  ),
                  SizedBox(height: 20),
                  MyCustomTextField(
                    controller: passwordController,
                    hintText: "Enter password",
                    prefixIcon: Icons.lock,
                    obscureText: _isObscure,
                    onSuffixTap: (){
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                  ),
                  SizedBox(height: 50,),
                  Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text("Sign Up", style: TextStyle(fontSize: 20)),
                    ),
                  ),
                  SizedBox(height: 40,),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(thickness: 1, color: Colors.grey[400]),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "Or Sign up with",
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(thickness: 1, color: Colors.grey[400]),
                      ),
                    ],
                  ),

                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SignInOptions(text: "Google", icon: Icons.safety_check),
                      SignInOptions(text: "Apple", icon: Icons.safety_check),
                    ],
                  ),

                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(color: Colors.blue, fontSize: 16),
                        ),
                      ),
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
