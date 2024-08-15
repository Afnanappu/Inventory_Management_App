import 'package:flutter/material.dart';
import 'package:inventory_management_app/constants/colors.dart';
import 'package:inventory_management_app/models/item_model.dart';
import 'package:inventory_management_app/widgets/appbar/app_bar_for_main.dart';
import 'package:inventory_management_app/widgets/floating_action_button.dart';
import 'package:inventory_management_app/widgets/item_list_tile.dart';

class ItemScreen extends StatelessWidget {
  const ItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: ListView.builder(
        itemCount: itemModelList.value.length,
        itemBuilder: (context, index) {

          return ItemListTile(
              image: itemModelList.value[index].itemImage,
              itemPrice: itemModelList.value[index].itemPrice,
              itemName: itemModelList.value[index].itemName,
              itemStock: itemModelList.value[index].stock.stock);
        },
      ),
      floatingActionButton: FloatingActionButtonForAll(text: "Add new item", onPressed: (){}, color: MyColors.red),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
