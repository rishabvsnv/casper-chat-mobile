import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            /* Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  // return HomeScreen();
                },
              ),
            ); */
          },
          child: Text('Login'),
        ),
      ),
    );
  }
}
