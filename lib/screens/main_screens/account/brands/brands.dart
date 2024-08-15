import 'package:flutter/material.dart';
import 'package:inventory_management_app/constants/colors.dart';
import 'package:inventory_management_app/screens/main_screens/account/brands/delete_brand.dart';
import 'package:inventory_management_app/screens/main_screens/account/brands/edit_brand.dart';
import 'package:inventory_management_app/widgets/appbar/app_bar_for_sub_with_edit.dart';
import 'package:inventory_management_app/screens/main_screens/account/brands/dialog_for_add_brand.dart';
import 'package:inventory_management_app/widgets/list_tile.dart';

class AccountBrands extends StatelessWidget {
  AccountBrands({super.key});

  final _addBrandController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.maxFinite, 60),
        child: AppBarForSubWithEdit(
          title: "Brands",
          isAddIcon: false,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: Column(
          children: [
            myListTile(
              context: context,
              title: 'Add Brand',
              icon: Icons.add,
              onTap: () {
                BrandShowDialog(
                  context: context,
                  title: 'Add new Brand',
                  text: 'Enter brand name',
                  controller: _addBrandController, buttonText: 'Add', buttonColor: MyColors.green,message: 'Brand added successfully'
                );
              },
            ),
            myListTile(
              context: context,
              title: 'Edit Brand',
              icon: Icons.edit_outlined,
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) =>  BrandAddNew()));
              },
            ),
            myListTile(
              context: context,
              title: 'Delete Brand',
              icon: Icons.delete_outline,
              onTap: () {
               
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) => const BrandDelete()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
