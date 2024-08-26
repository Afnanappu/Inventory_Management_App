import 'package:flutter/material.dart';

// Widget _customSnackBarMessage(){
//   return ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
// }

class CustomSnackBarMessage {
  CustomSnackBarMessage({
    required BuildContext context,
    required String message,
    required Color color,
    int duration = 4,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: color,
      margin: const EdgeInsets.all(10),
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: duration),
    ));
  }
}
