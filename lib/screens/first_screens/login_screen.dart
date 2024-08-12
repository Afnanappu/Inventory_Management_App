import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          child: Column(
            children: [
              Image.asset('assets/splash logo black.png'),
              
            ],
          ),
        ),
      ),
    );
  }
}
