import 'dart:io';

import 'package:flutter/material.dart';
import 'package:inventory_management_app/constants/colors.dart';
import 'package:inventory_management_app/constants/screen_size.dart';
import 'package:inventory_management_app/functions/pick_image.dart';

class AddItemImageForAddOrEditItemScreen extends StatelessWidget {
  const AddItemImageForAddOrEditItemScreen({
    super.key,
    required this.imageNotifier,
  });

  final ValueNotifier<String?> imageNotifier;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await pickImageFromFile().then(
          (value) {
            imageNotifier.value = value;
          },
        );
      },

      //image
      child: ValueListenableBuilder(
        valueListenable: imageNotifier,
        builder: (context, value, child) => Container(
          height: MyScreenSize.screenHeight * 0.4,
          width: MyScreenSize.screenWidth * 0.8,
          decoration: BoxDecoration(
              image: (value != null)
                  ? DecorationImage(
                      image: FileImage(File(value)), fit: BoxFit.contain)
                  : null,
              color: MyColors.lightGrey,
              borderRadius: BorderRadius.circular(10)),
          child: Center(
            child: (value == null) ? const Text('add image') : null,
          ),
        ),
      ),
    );
  }
}
