import 'package:flutter/material.dart';

class MyScreenSize {
  static late final double screenWidth;
  static late final double screenHeight;

  static void initialize(BuildContext context){
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
  }
}