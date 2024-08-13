import 'package:flutter/material.dart';
import 'package:inventory_management_app/constants/colors.dart';

class MyButton extends StatelessWidget {
  Color color;
  String text;
  void Function() function;
  MyButton(
      {super.key,
      required this.color,
      required this.text,
      required this.function});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: function,
      style: ButtonStyle(
        backgroundColor: WidgetStateColor.resolveWith(
          (states) => MyColors.green,
        ),
      ),
      child: Text(text,style:const TextStyle(color: MyColors.white),),
    );
  }
}
