import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management_app/constants/screen_size.dart';
import 'package:inventory_management_app/screens/first_screens/login_screen.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // afterDelayed(context);
    MyScreenSize.initialize(context);
    return Scaffold(
      body: AnimatedSplashScreen(
        splash: Container(
          height: MyScreenSize.screenHeight,
          width: MyScreenSize.screenWidth,
          child: LottieBuilder.asset(
            'assets/animations/Flow.json',
            repeat: false,
          ),
        ),
        nextScreen: LoginScreen(),
      ),
    );
  }

// Scaffold(
  //   body: Center(child: Image.asset("assets/splash logo black.png",),),
  // );
  // Future<void> afterDelayed(context) async{
  //   await Future.delayed(const Duration(seconds: 3));
  //   Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>const LoginScreen()));
  // }
}
