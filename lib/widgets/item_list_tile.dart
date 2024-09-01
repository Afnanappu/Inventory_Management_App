import 'dart:io';
import 'package:flutter/material.dart';
import 'package:inventory_management_app/constants/colors.dart';
import 'package:inventory_management_app/constants/font_styles.dart';
import 'package:inventory_management_app/database/item_fun.dart';
import 'package:inventory_management_app/functions/format_money.dart';
import 'package:inventory_management_app/models/item_model.dart';
import 'package:inventory_management_app/screens/main_screens/item/add_or_edit_new_item.dart';
import 'package:inventory_management_app/widgets/popup_icon_button_for_all.dart';
import 'package:inventory_management_app/widgets/snack_bar_messenger.dart';

// ignore: must_be_immutable
class ItemListTile extends StatelessWidget {
  final int index;
  final ItemModel itemModel;
  // ignore: avoid_annotating_with_dynamic

  const ItemListTile({
    super.key,
    required this.index,
    required this.itemModel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: MyColors.lightGrey,
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          leading: Image.file(
            File(itemModel.itemImage),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  itemModel.itemName,
                  style: MyFontStyle.saleTile,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              popUpIconButtonForAll(
                itemBuilder: (context) => [
                  PopupMenuItem(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => ItemAddNew(
                            itemModel: itemModel,
                            isAddingItem: false,
                            removeBelowRoute: false,
                          ),
                        ),
                      );
                    },
                    child: const Text('Edit'),
                  ),
                  PopupMenuItem(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Delete item'),
                          content: const Text('Are you sure?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                deleteItemFromDB(index);
                                Navigator.of(context).pop();
                                CustomSnackBarMessage(
                                  context: context,
                                  message: 'Item deleted successfully',
                                  color: MyColors.green,
                                );
                              },
                              child: const Text('Yes'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('No'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: const Text('Delete'),
                  ),
                ],
              )
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                (itemModel.stock>=1)?'${itemModel.stock} in stock':'Out of stock',
                style:  TextStyle(
                    color: (itemModel.stock>10)?MyColors.green:MyColors.red,
                    fontSize: 13,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                formatMoney(number: itemModel.itemPrice),
                style: MyFontStyle.saleTile,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
