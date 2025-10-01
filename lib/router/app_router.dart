import 'package:flutter/material.dart';
import 'package:vericon/auth/login_screen.dart';
import 'package:vericon/auth/register_screen.dart';
import 'package:vericon/features/navigation/main_screen.dart';
import 'package:vericon/features/onboarding/onboarding_screen.dart';
import 'package:vericon/features/splash/splash_screen.dart';

class AppRouter {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String main = '/main';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case main:
        return MaterialPageRoute(builder: (_) => const MainScreen());
      default:
        return MaterialPageRoute(
          builder: (_) =>
              Scaffold(body: Center(child: Text("Page note found"))),
        );
    }
  }
}
