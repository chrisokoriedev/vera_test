import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 14, right: 14, top: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
            Text("Welcome to VeriConnect", style: TextStyle(fontSize:30),),
            SizedBox(height: 10,),
            AuthButtons(text: 'Log in',),
            SizedBox(height: 15,),
            AuthButtons(text: "Sign Up"),
            SizedBox(height: 30,),
            Text("Continue with Accounts", style: TextStyle(fontSize: 16),),
            SizedBox(height: 10,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SignInOptions(icon: Icons.safety_check, text: "Google",),
                SignInOptions(icon: Icons.safety_check, text: "Github",)
              ],
            ),
            SizedBox(height: 20,)

          ],
        ),
      ),
    );
  }
}

class SignInOptions extends StatelessWidget {
  final String text;
  final IconData icon;
  const SignInOptions({
    super.key,
   required  this.text,
    required this.icon

  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.lightBlue.shade100,
      borderRadius: BorderRadius.circular(10)
    ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon),
          SizedBox(width: 5,),
          Text(text)
        ],
      ),
    );
  }
}

class AuthButtons extends StatelessWidget {
  final String text;
  const AuthButtons({
    super.key,
    required this.text
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(15)
      ),
      child: Center(child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(text, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),),
      )),
    );
  }
}
