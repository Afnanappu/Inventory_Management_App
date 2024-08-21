import 'package:flutter/material.dart';
import 'package:inventory_management_app/constants/colors.dart';

Widget buttonAddSale({
  required String text,
  void Function()? onTap,
  double radius = 15,
}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
        color: MyColors.green,
        borderRadius: BorderRadius.circular(radius),
        ),
        child: Center(
          child: Text(
            text,
            style:const TextStyle(
                color: MyColors.white, fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    ),
  );
}
