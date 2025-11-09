import 'package:flutter/material.dart';
import 'package:vericon/auth/auth_widgets.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/images/Logistics.jpg",
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.40,
            fit: BoxFit.cover,
          ),

          Align(
            alignment:Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.65,
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
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // SizedBox(height: 300),
                      Text("Welcome back", style: TextStyle(fontSize: 30, color: Colors.black)),
                      SizedBox(height: 20),

                      //Email Address TextFeild
                      MyCustomTextField(
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        controller: _emailController,
                        hintText: "Email",
                        prefixIcon: Icons.email,
                      ),
                      SizedBox(height: 20),

                      // Password TextField
                      MyCustomTextField(
                        textInputAction: TextInputAction.next,
                        controller: _passwordController,
                        hintText: "Password",
                        prefixIcon: Icons.lock,
                        obscureText: _isObscure,
                        onSuffixTap: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },
                      ),

                      //Forgot password
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                              context,
                              '/forgotpassword',
                            );
                          },
                          child: const Text(
                            "Forgot Password?",
                            style: TextStyle(color: Colors.blue, fontSize: 16),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      GestureDetector(
                        onTap: (){
                          Navigator.pushReplacementNamed(context, '/main');
                        },
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text("Log in", style: TextStyle(fontSize: 20, color: Colors.white)),
                          ),
                        ),
                      ),
                      SizedBox(height: 50),

                      //Login Options
                      Row(
                        children: [
                          Expanded(
                            child: Divider(thickness: 1, color: Colors.grey[400]),
                          ),
                          Text(
                            "Or Login with",
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 15,
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
                          SignInOptions(text: "Google", imagePath: "assets/images/google (2).png"),
                          SignInOptions(text: "Apple", imagePath: "assets/images/apple 3.png"),
                        ],
                      ),

                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account?",
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(width: 10),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacementNamed(context, '/register');
                            },
                            child: Text(
                              "Sign Up",
                              style: TextStyle(color: Colors.blue, fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
