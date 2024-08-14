import 'package:flutter/material.dart';
import 'package:inventory_management_app/constants/colors.dart';
import 'package:inventory_management_app/widgets/buttons.dart';
import 'package:inventory_management_app/widgets/text_form_field.dart';

class AddBrandShowDialog {
  AddBrandShowDialog(
      {required BuildContext context,
      required String title,
      required String text,
      required TextEditingController controller}) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: customFormField(
            context: context, text: text, controller: controller),
        actions: [
          MyButton(
              color: MyColors.green,
              text: 'Add',
              function: () {
                Navigator.of(context).pop();
              })
        ],
      ),
    );
  }
}
