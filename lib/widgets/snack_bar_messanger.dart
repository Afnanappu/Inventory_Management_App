import 'package:flutter/material.dart';

// Widget _customSnackBarMessage(){
//   return ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
// }

class CustomSnackBarMessage{
  CustomSnackBarMessage({required BuildContext context, required String message,required Color color}){
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message),backgroundColor: color,margin:const EdgeInsets.all(10),behavior: SnackBarBehavior.floating,));
  }
}