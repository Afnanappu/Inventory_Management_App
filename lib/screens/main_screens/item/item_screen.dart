import 'package:flutter/material.dart';
import 'package:inventory_management_app/constants/colors.dart';
import 'package:inventory_management_app/database/item_fun.dart';
import 'package:inventory_management_app/models/item_model.dart';
import 'package:inventory_management_app/screens/main_screens/item/add_or_edit_new_item.dart';
import 'package:inventory_management_app/widgets/appbar/app_bar_for_main.dart';
import 'package:inventory_management_app/widgets/floating_action_button.dart';
import 'package:inventory_management_app/widgets/item_list_tile.dart';
import 'package:inventory_management_app/widgets/popup_icon_button_for_all.dart';

class ItemScreen extends StatelessWidget {
  const ItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    getTheFilterItem();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.maxFinite, 60),
        child: AppBarForMain(
          title: 'Item',
          haveBorder: false,
          isPopupMenuButton: true,
          popupMenuButton: popUpIconButtonForAll(
            icon: Icons.filter_alt_outlined,
            itemBuilder: (context) => [
              PopupMenuItem(
                onTap: () {
                  getTheFilterItem();
                },
                child: const Text('All item'),
              ),
              PopupMenuItem(
                onTap: () {
                  getTheFilterItem(limit: 0, isLess: false);
                },
                child: const Text('In stock'),
              ),
              PopupMenuItem(
                onTap: () {
                  getTheFilterItem(limit: 1);
                },
                child: const Text('Out of stock item'),
              ),
            ],
          ),
          onPressed: () {},
        ),
      ),
      body: (itemModelListNotifiers.value.isEmpty)
          ? const Center(child: Text('No item added'))
          : ValueListenableBuilder(
              valueListenable: itemFilterListNotifiers,
              builder: (context, itemModel, child) => ListView.builder(
                itemCount: itemModel.length,
                itemBuilder: (context, index) {
                  return ItemListTile(
                    index: index,
                    itemModel: itemModel[index],
                  );
                },
              ),
            ),
      floatingActionButton: FloatingActionButtonForAll(
          text: "Add new item",
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => const ItemAddNew(),
              ),
            );
          },
          color: MyColors.red,),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
