// ignore_for_file: avoid_annotating_with_dynamic

import 'package:flutter/material.dart';
import 'package:inventory_management_app/constants/colors.dart';
import 'package:inventory_management_app/constants/font_styles.dart';

class DropDownForAll extends StatelessWidget {
  List<DropdownMenuItem<dynamic>> items;
  String? Function(dynamic)? validator;
  void Function(dynamic)? onChanged;
  Color formFillColor = MyColors.lightGrey;
  DropDownForAll({
    super.key,
    required this.items,
    required this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      hint: const Text(
        '---Select brand---',
        style: MyFontStyle.smallLightGrey,
      ),
      
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
