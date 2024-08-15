import 'package:flutter/material.dart';
import 'package:inventory_management_app/constants/colors.dart';
import 'package:inventory_management_app/constants/font_styles.dart';

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
      child: Text(
        text,
        style: const TextStyle(color: MyColors.white),
      ),
    );
  }
}

class MyCustomButton extends StatelessWidget {
  void Function()? onTap;
  final Color color;
  final String text;
  final bool haveBgColor;
  MyCustomButton(
      {super.key,
      required this.color,
      required this.text,
      this.haveBgColor = true});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
        decoration: BoxDecoration(
          border: Border.all(color: color),
          color: (haveBgColor == true) ? color : null,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: MyColors.green,
            fontSize: 11,
            fontWeight: FontWeight.w500

          ),
        ),
      ),
    );
  }
}
