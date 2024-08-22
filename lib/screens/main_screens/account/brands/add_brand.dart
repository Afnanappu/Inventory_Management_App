import 'package:flutter/material.dart';
import 'package:inventory_management_app/constants/colors.dart';
import 'package:inventory_management_app/models/item_model.dart';
import 'package:inventory_management_app/widgets/buttons.dart';
import 'package:inventory_management_app/widgets/snack_bar_messenger.dart';
import 'package:inventory_management_app/widgets/text_form_field.dart';

class BrandAddNew {
  BrandAddNew({
    required BuildContext context,
    required String title,
    String? text,
    int? brandId,
    TextEditingController? controller,
    String? controllerValue,
    required String buttonText,
    required Color buttonColor,
    required String message,
    String errorMessage = 'Error',
    bool haveTextField = true,
    String? content,
    void Function()? buttonFunction,
    void Function(int)? buttonFunctionWithArg,
    void Function(int, ItemBrandModel)? buttonFunctionWithArgAndBrand,
  }) {
    if (controllerValue != null) {
      controller!.text = controllerValue;
    }
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: (haveTextField == true)
            ? customFormField(
                context: context,
                labelText: text!,
                controller: controller!,
              )
            : null,
        actions: [
          MyButton(
              color: buttonColor,
              text: buttonText,
              function: () {
                try {
                  if (buttonFunction != null) {
                    buttonFunction();
                  }
                  if (buttonFunctionWithArg != null && brandId != null) {
                    buttonFunctionWithArg(brandId);
                  }
                  if (buttonFunctionWithArgAndBrand != null &&
                      brandId != null) {
                    final brand = ItemBrandModel(
                        itemBrandName: controller!.text, id: brandId);
                    buttonFunctionWithArgAndBrand(brandId, brand);
                    print('brand is edited');
                  }
                  CustomSnackBarMessage(
                      context: context,
                      message: message,
                      color: MyColors.green);
                  Navigator.of(context).pop();
                } catch (e) {
                  CustomSnackBarMessage(
                      context: context,
                      message: errorMessage,
                      color: MyColors.red);
                  Navigator.of(context).pop();
                }
              })
        ],
      ),
    );
  }
}
