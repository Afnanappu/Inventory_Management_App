import 'package:flutter/material.dart';
import 'package:inventory_management_app/constants/colors.dart';
import 'package:inventory_management_app/database/brand_fun.dart';
import 'package:inventory_management_app/models/item_model.dart';
import 'package:inventory_management_app/screens/main_screens/account/brands/add_brand.dart';
import 'package:inventory_management_app/widgets/appbar/app_bar_for_sub_with_edit.dart';
import 'package:inventory_management_app/widgets/list_tile.dart';

class BrandEdit extends StatelessWidget {
  BrandEdit({super.key});

  final _editBrandController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.maxFinite, 60),
        child: AppBarForSubWithEdit(
          title: "Edit Brand",
          isAddIcon: false,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: ValueListenableBuilder(
          valueListenable: itemBrandListNotifiers,
          builder: (context, brand, child) => ListView.builder(
            itemCount: brand.length,
            itemBuilder: (context, index) => myListTile(
              context: context,
              title: brand[index].itemBrandName,
              haveLeading: false,
              haveTrailing: true,
              onTap: () {
                BrandAddNew(
                  context: context,
                  index: index,
                  controllerValue:  brand[index].itemBrandName,
                  title: 'Edit brand',
                  text: 'Brand name',
                  controller: _editBrandController,
                  buttonText: 'Save',
                  buttonColor: MyColors.green,
                  message: 'Brand edited successfully',
                  buttonFunctionWithArgAndBrand: (index, brand) {
                    editBrandFromDB(index, brand);
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
