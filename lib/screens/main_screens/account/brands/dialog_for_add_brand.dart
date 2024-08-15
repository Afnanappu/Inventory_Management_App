import 'package:flutter/material.dart';
import 'package:inventory_management_app/constants/colors.dart';
import 'package:inventory_management_app/widgets/buttons.dart';
import 'package:inventory_management_app/widgets/snack_bar_messenger.dart';
import 'package:inventory_management_app/widgets/text_form_field.dart';

class BrandShowDialog {
  BrandShowDialog({
    required BuildContext context,
    required String title,
    String? text,
    TextEditingController? controller,
    required String buttonText,
    required Color buttonColor,
    required String message,
    bool haveTextField = true,
    String? content,
  }) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: (haveTextField == true)
            ? customFormField(
                context: context, text: text!, controller: controller!)
            : null,
        actions: [
          MyButton(
              color: buttonColor,
              text: buttonText,
              function: () {
                CustomSnackBarMessage(
                    context: context, message: message, color: MyColors.green);
                Navigator.of(context).pop();
              })
        ],
      ),
    );
  }
}
