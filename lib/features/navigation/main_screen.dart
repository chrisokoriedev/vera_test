import 'package:flutter/material.dart';
import 'package:vericon/Home/home_screen.dart';
import 'package:vericon/Logistics/logistics_screen.dart';
import 'package:vericon/Profile/profile_screen.dart';
import 'package:vericon/Training/training_screen.dart';

class MainScreen extends StatelessWidget {
   MainScreen({super.key});
int _currentIndex = 0;
  final List _screens = [
    HomeScreen(),
    LogisticsScreen(),
    ProfileScreen(),
    TrainingScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(items: []),
    );
  }
}
