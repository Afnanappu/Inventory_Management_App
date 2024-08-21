// ignore_for_file: avoid_annotating_with_dynamic

import 'package:flutter/material.dart';
import 'package:inventory_management_app/constants/colors.dart';
import 'package:inventory_management_app/constants/font_styles.dart';

// ignore: must_be_immutable
class DropDownForAll extends StatelessWidget {
  List<DropdownMenuItem<dynamic>> items;
  String? Function(dynamic)? validator;
  void Function(dynamic)? onChanged;
  void Function()? onTap;
  Color formFillColor;
  DropDownForAll({
    super.key,
    required this.items,
    required this.onChanged,
    this.validator,
    this.onTap,
    this.formFillColor = MyColors.lightGrey,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      hint: const Text(
        'Select brand',
        style: MyFontStyle.smallLightGrey,
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      borderRadius: BorderRadius.circular(20),
      dropdownColor: MyColors.white,
      onTap: onTap,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        fillColor: formFillColor,
        filled: true,
        labelStyle: MyFontStyle.smallLightGrey,
        floatingLabelStyle: const TextStyle(
          color: MyColors.blackShade,
        ),
        contentPadding: const EdgeInsets.only(left: 20),
        hintFadeDuration: const Duration(milliseconds: 200),
      ),
      validator: validator,
      items: items,
      onChanged: onChanged,
    );
  }
}
