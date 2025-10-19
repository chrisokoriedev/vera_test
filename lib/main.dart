import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vericon/Providers/auth_provider.dart';
import 'package:vericon/router/app_router.dart';
import 'package:vericon/theme/app_theme.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthProvider())],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRouter.splash,
      onGenerateRoute: AppRouter.generateRoute,
      theme: AppTheme.lightTheme,
    );
  }
}
