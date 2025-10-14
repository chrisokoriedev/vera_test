import 'package:flutter/material.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';
import 'package:vericon/Home/home_screen.dart';
import 'package:vericon/Logistics/logistics_screen.dart';
import 'package:vericon/Profile/profile_screen.dart';
import 'package:vericon/Training/training_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    LogisticsScreen(),
    TrainingScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],

      bottomNavigationBar: WaterDropNavBar(
        waterDropColor: Colors.blue,
        barItems: [
          BarItem(filledIcon: Icons.home, outlinedIcon: Icons.home_outlined),
          BarItem(filledIcon: Icons.local_shipping, outlinedIcon: Icons.local_shipping_outlined),
          BarItem(filledIcon: Icons.school, outlinedIcon: Icons.school_outlined),
          BarItem(filledIcon: Icons.person, outlinedIcon: Icons.person_2_outlined)
        ],
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
