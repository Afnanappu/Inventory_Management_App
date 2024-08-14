import 'package:flutter/material.dart';
import 'package:inventory_management_app/constants/colors.dart';
import 'package:inventory_management_app/constants/font_styles.dart';

Widget myListTile({
  required BuildContext context,
  required String title,
  required IconData icon,
  void Function()? onTap,
}) {
  return Card(
    elevation: 0.5,
    color: MyColors.lightGrey,
    margin: const EdgeInsets.symmetric(vertical: 12),
    child: ListTile(
      onTap: onTap,
      title: Text(
        title,
        style: MyFontStyle.listTileFont,
      ),
      leading: Icon(
        icon,
        size: 30,
        color: MyColors.blackShade,
      ),
    ),
  );
}
