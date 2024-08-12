import 'package:flutter/material.dart';
import 'package:inventory_management_app/constants/colors.dart';
import 'package:inventory_management_app/constants/font_styles.dart';
import 'package:inventory_management_app/constants/screen_size.dart';

class AppBarForMain extends StatelessWidget {
  const AppBarForMain({super.key, required this.title});

  final String title;

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
          onPressed: () {
            Navigator.of(context).pushNamed("/NotificationScreen");
          },
          icon: Container(
            decoration: BoxDecoration(
              border: Border.all(color: MyColors.darkGrey),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Padding(
              padding: EdgeInsets.all(5),
              child: Icon(Icons.notifications_none),
            ),
          ),
        ),
         SizedBox(width: MyScreenSize.screenWidth*0.03,)
      ],
    );
  }
}
