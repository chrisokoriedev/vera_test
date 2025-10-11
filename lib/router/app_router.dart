import 'package:flutter/material.dart';
import 'package:vericon/auth/AuthSelecetionScreen.dart';
import 'package:vericon/auth/forgot_password.dart';
import 'package:vericon/auth/login_screen.dart';
import 'package:vericon/auth/register_screen.dart';
import 'package:vericon/features/navigation/main_screen.dart';
import 'package:vericon/features/onboarding/onboarding_screen.dart';
import 'package:vericon/features/splash/splash_screen.dart';

class AppRouter {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String authselection = '/authselectionscreen';
  static const String forgotpassword = '/forgotpassword';
  static const String register = '/register';
  static const String main = '/main';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case authselection:
         return MaterialPageRoute(builder: (_) => AuthSelectionScreen());
      case login:
        return MaterialPageRoute(builder: (_) =>  LoginScreen());
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case forgotpassword:
        return MaterialPageRoute(builder: (_) => ForgotPassword() );
      case main:
        return MaterialPageRoute(builder: (_) =>  MainScreen());
      default:
        return MaterialPageRoute(
          builder: (_) =>
              Scaffold(body: Center(child: Text("Page note found"))),
        );
    }
  }
}
