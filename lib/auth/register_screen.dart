
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vericon/auth/auth_widgets.dart';
import 'package:vericon/Providers/auth_provider.dart';



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
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.70,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFF6FBFF), Color(0xFFDCEBFF)],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Create Your Account",
                        style: TextStyle(fontSize: 30, color: Colors.black),
                      ),
                      SizedBox(height: 20),

                      //Full Name TextField
                      MyCustomTextField(
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        controller: fullNameController,
                        hintText: "Enter full name",
                        prefixIcon: Icons.person,
                      ),
                      SizedBox(height: 20),

                      //Email TextField
                      MyCustomTextField(
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        hintText: "Enter email",
                        prefixIcon: Icons.email,
                      ),
                      SizedBox(height: 20),

                      //Password TextField
                      MyCustomTextField(
                        textInputAction: TextInputAction.next,
                        controller: passwordController,
                        hintText: "Enter password",
                        prefixIcon: Icons.lock,
                        obscureText: _isObscure,
                        onSuffixTap: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },
                      ),

                      SizedBox(height: 50),

                      //Sign Up Button
                      GestureDetector(
                        onTap:  ()async{
                          if(_formKey.currentState!.validate()){
                            final authProvider = Provider.of<AuthProviderService>(context, listen: false);
                            String? result  = await authProvider.signUp(
                              emailController.text.trim(),
                              passwordController.text.trim()
                            );

                            if(result == null){
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Account created successfully"))
                              );
                              Navigator.pushReplacementNamed(context, '/login');
                            }else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("result"),)
                              );
                            }
                          }

                        },
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              "Sign Up",
                              style: TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 40),

                      // Sign Up Options
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: 1,
                              color: Colors.grey[400],
                            ),
                          ),
                          Text(
                            "Or Sign up with",
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 14,
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 1,
                              color: Colors.grey[400],
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SignInOptions(
                            text: "Google",
                            imagePath: "assets/images/google (2).png",
                          ),
                          SignInOptions(
                            text: "Apple",
                            imagePath: "assets/images/apple 3.png",
                          ),
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
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 16,
                              ),
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
