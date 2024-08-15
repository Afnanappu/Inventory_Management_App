import 'package:flutter/material.dart';
import 'package:inventory_management_app/constants/colors.dart';
import 'package:inventory_management_app/models/item_model.dart';
import 'package:inventory_management_app/screens/main_screens/account/brands/dialog_for_add_brand.dart';
import 'package:inventory_management_app/widgets/appbar/app_bar_for_sub_with_edit.dart';
import 'package:inventory_management_app/widgets/list_tile.dart';

class BrandDelete extends StatelessWidget {
  const BrandDelete({super.key});

  @override
  Widget build(BuildContext context) {
    final listItems = List.generate(
      brandItemList.length - 1,
      (index) => myListTile(
          context: context,
          title: brandItemList[index + 1],
          haveLeading: false,
          haveTrailing: true,
          trailIcon: Icons.delete_outline,
          onTap: () {
            BrandShowDialog(
              context: context,
              title: 'Delete brand',
              buttonText: 'Delete',
              buttonColor: MyColors.red,
              message: 'Brand deleted successfully',
              haveTextField: false,
              content: 'Are you sure?',
            );
          }),
    );
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.maxFinite, 60),
        child: AppBarForSubWithEdit(
          title: "Delete Brand",
          isAddIcon: false,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: Column(
          children: [
            ...listItems,
          ],
        ),
      ),
    );
  }
}
