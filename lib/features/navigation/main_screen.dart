import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
   MainScreen({super.key});

  final List bottomNavigation = [];

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      bottomNavigationBar: Bottom,
    );
  }
}
