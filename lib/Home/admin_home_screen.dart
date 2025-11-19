
import 'package:flutter/material.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome to Admin DashBoard"),
      ),
      body: Column(
        children: [
          Center(
            child: Text("Hello I am the admin"),
          )
        ],
      ),
    );
  }
}
