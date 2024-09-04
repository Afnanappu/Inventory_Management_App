import 'package:flutter/material.dart';
import 'package:inventory_management_app/constants/colors.dart';
import 'package:inventory_management_app/database/item_fun.dart';
import 'package:inventory_management_app/models/item_model.dart';
import 'package:inventory_management_app/screens/sub_screens/add_or_edit_new_item_screen.dart';
import 'package:inventory_management_app/widgets/common/floating_action_button.dart';
import 'package:inventory_management_app/widgets/item_screen_widgets/app_bar_for_item_screen.dart';
import 'package:inventory_management_app/widgets/item_screen_widgets/item_list_for_item_screen.dart';

class ItemScreen extends StatelessWidget {
  const ItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    getTheFilterItem();
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size(double.maxFinite, 60),
        child: AppBarForItemScreen(),
      ),
      body: (itemModelListNotifiers.value.isEmpty)
          ? const Center(child: Text('No item added'))
          : const ItemListForItemScreen(),

          
      floatingActionButton: FloatingActionButtonForAll(
        text: "Add new item",
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => const ItemAddNew(),
            ),
          );
        },
        color: MyColors.red,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
