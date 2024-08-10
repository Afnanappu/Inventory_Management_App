import 'package:flutter/material.dart';
import 'package:inventory_management_app/constants/font_styles.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text(
          "No notifications",
          style: MyFontStyle.lightGreyStyle,
        ),
      ),
    );
  }
}
