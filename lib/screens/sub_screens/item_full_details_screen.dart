import 'dart:io';

import 'package:flutter/material.dart';
import 'package:inventory_management_app/constants/colors.dart';
import 'package:inventory_management_app/constants/screen_size.dart';
import 'package:inventory_management_app/widgets/appbar/app_bar_for_item_full_details.dart';

class ItemFullDetails extends StatelessWidget {
  final String? image;
  ItemFullDetails({super.key, required this.image}) {
    print(image);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                color: MyColors.lightGrey,
                height: MyScreenSize.screenHeight * 0.5,
                child: Center(
                    child: Image.file(
                  File('assets/mobiles/Redmi 13C 5G.png'),
                )),
              ),
              PreferredSize(
                preferredSize: const Size(double.maxFinite, 60),
                child: AppBarForItemFullDetails(onPressed: () {
                  print('object');
                }),
              ),
            ],
          )
        ],
      ),
    );
  }
}
