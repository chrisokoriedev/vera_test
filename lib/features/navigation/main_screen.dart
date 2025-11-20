import 'package:flutter/material.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:vericon/Home/home_screen.dart';
import 'package:vericon/Home/admin_home_screen.dart';
import 'package:vericon/Logistics/logistics_screen.dart';
import 'package:vericon/Profile/profile_screen.dart';
import 'package:vericon/Training/training_screen.dart';
import 'package:vericon/Providers/user_provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  List<Widget> _getScreens(bool isAdmin) {
    if (isAdmin) {
      return [
        AdminHomeScreen(),
        LogisticsScreen(),
        TrainingScreen(),
        ProfileScreen(),
      ];
    } else {
      return [
        HomeScreen(),
        LogisticsScreen(),
        TrainingScreen(),
        ProfileScreen(),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final isAdmin = userProvider.isAdmin;
    final screens = _getScreens(isAdmin);

    // Fetch user data if not loaded
    if (userProvider.currentUser == null && !userProvider.isLoading) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        userProvider.fetchUserData();
      });
    }

    return Scaffold(
      body: userProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : screens[_currentIndex],

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
