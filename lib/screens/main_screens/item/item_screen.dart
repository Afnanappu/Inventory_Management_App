import 'package:flutter/material.dart';
import 'package:inventory_management_app/constants/colors.dart';
import 'package:inventory_management_app/constants/screen_size.dart';
import 'package:inventory_management_app/database/item_fun.dart';
import 'package:inventory_management_app/models/item_model.dart';
import 'package:inventory_management_app/screens/main_screens/item/add_or_edit_new_item.dart';
import 'package:inventory_management_app/widgets/appbar/app_bar_for_main.dart';
import 'package:inventory_management_app/widgets/floating_action_button.dart';
import 'package:inventory_management_app/widgets/item_list_tile.dart';

class ItemScreen extends StatelessWidget {
  const ItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    getAllItemFormDB();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.maxFinite, 60),
        child: AppBarForMain(
          title: 'Item',
          haveBorder: false,
          icon: Icons.filter_alt_outlined,
          onPressed: () {},
        ),
      ),
      body: (itemModelListNotifiers.value.isEmpty)
          ? const Center(child: Text('No item added'))
          : ValueListenableBuilder(
              valueListenable: itemModelListNotifiers,
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
          color: MyColors.red),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
