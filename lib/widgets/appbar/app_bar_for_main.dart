import 'package:flutter/material.dart';
import 'package:inventory_management_app/constants/colors.dart';
import 'package:inventory_management_app/constants/font_styles.dart';
import 'package:inventory_management_app/constants/screen_size.dart';

class AppBarForMain extends StatelessWidget {
  AppBarForMain(
      {super.key,
      required this.title,
      this.icon = Icons.notifications_none,
      required this.onPressed});

  final String title;
  final IconData icon;
  void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // backgroundColor: MyColors.lightGrey,
      title: Text(
        title,
        style: MyFontStyle.main,
      ),
      actions: [
        IconButton(
          onPressed: onPressed,
          icon: Container(
            decoration: BoxDecoration(
              border: Border.all(color: MyColors.darkGrey),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Icon(icon),
            ),
          ),
        ),
        SizedBox(
          width: MyScreenSize.screenWidth * 0.03,
        )
      ],
    );
  }
}
