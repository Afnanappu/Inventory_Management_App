import 'package:flutter/material.dart';
import 'package:inventory_management_app/screens/first_screens/login_screen.dart';
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    afterDelayed(context);
    return Scaffold(
      body: Center(child: Image.asset("assets/splash logo black.png",),),
    );
  }

  Future<void> afterDelayed(context) async{
    await Future.delayed(const Duration(seconds: 3));
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>const LoginScreen()));
  }
}