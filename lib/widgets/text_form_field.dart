import 'package:flutter/material.dart';
import 'package:inventory_management_app/constants/colors.dart';
import 'package:inventory_management_app/constants/font_styles.dart';

Widget customFormField({required BuildContext context, required String text, required TextEditingController controller, String? Function(String?)? validator, bool? enabled = true}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: TextFormField(
        controller: controller,
        validator: validator,
        enabled: enabled,
        cursorOpacityAnimates: true,
        cursorColor: MyColors.blackShade,
        enableInteractiveSelection: true,
        keyboardType: TextInputType.text,
        cursorHeight: 18,
        onTapOutside: (event) {
          //To remove the focus.
          // ignore: use_build_context_synchronously
          FocusScope.of(context).unfocus();
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          fillColor: MyColors.lightGrey,
          filled: true,
          labelText: text,
          labelStyle: MyFontStyle.smallLightGrey,
          floatingLabelStyle: TextStyle(color: MyColors.blackShade,),
          contentPadding: const EdgeInsets.only(left: 20),
          hintFadeDuration: const Duration(milliseconds: 200),
        ),
      ),
    );
  }