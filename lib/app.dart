import 'package:flutter/material.dart';
import 'package:messenger/core/constants/app_constants.dart';
import 'package:messenger/core/theme/app_theme.dart';
import 'package:messenger/features/auth/presentation/screens/login_screen.dart';

class MyMessengerApp extends StatelessWidget {
  const MyMessengerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConstants.appName,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      home: LoginScreen(),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
