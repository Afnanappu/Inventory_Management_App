import 'package:flutter/material.dart';
import 'package:inventory_management_app/constants/colors.dart';
import 'package:inventory_management_app/constants/font_styles.dart';

class AppBarForMain extends StatelessWidget {
  const AppBarForMain({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // backgroundColor: MyColors.lightGrey,
      title: Text(
        title,
        style: MyFontStyle.mainFontStyle,
      ),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed("/NotificationScreen");
          },
          icon: Container(
            decoration: BoxDecoration(
              border: Border.all(color: MyColors.darkGrey),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Padding(
              padding:  EdgeInsets.all(5.0),
              child: Icon(Icons.notifications_none),
            ),
          ),
        ),
        const SizedBox(width: 10,)
      ],
    );
  }
}
