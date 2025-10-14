import 'package:flutter/material.dart';

class LogisticsScreen extends StatelessWidget {
  const LogisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text("Logistics Screen 🚛", style:  TextStyle(fontSize: 20),))
        ],
      ),
    );
  }
}
