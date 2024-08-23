import 'dart:math';

import 'package:flutter/material.dart';
import 'package:inventory_management_app/constants/colors.dart';
import 'package:inventory_management_app/models/item_model.dart';
import 'package:inventory_management_app/widgets/appbar/app_bar_for_sub_with_edit.dart';
import 'package:inventory_management_app/widgets/button_add_sale.dart';
import 'package:inventory_management_app/widgets/drop_down_for_all.dart';
import 'package:inventory_management_app/widgets/text_form_field.dart';

class AddNewItemInSale extends StatelessWidget {
  AddNewItemInSale({super.key});

  final _itemNameController = TextEditingController();
  final _itemStockController = TextEditingController();
  var itemId = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.maxFinite, 60),
        child: AppBarForSubWithEdit(
          title: 'Add item to Sale',
          isAddIcon: false,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            // customFormField(
            //   context: context,
            //   labelText: 'Item name',
            //   controller: _itemNameController,
            //   formFillColor: MyColors.white,
            //   haveBorder: true,
            //   isFormEnabled: true,
            //   validator: (value) {
            //     if (value == null || value.isEmpty) {
            //       return 'Item name is empty';
            //     } else if (value.length < 3) {
            //       return 'Enter a valid name';
            //     } else {
            //       return null;
            //     }
            //   },
            // ),

            DropDownForAll(
              formFillColor: MyColors.white,
              haveBorder: true,
              items: itemModelListNotifiers.value
                  .map(
                    (e) => DropdownMenuItem(
                      value: e.id,
                      child: Text(e.itemName),
                    ),
                  )
                  .toList(),
              onChanged: (e) {
                itemId = e;
              },
              hintText: 'Select item',
            ),
            Row(
              children: [
                Expanded(
                  child: customFormField(
                    context: context,
                    labelText: 'Price',
                    controller: _itemNameController,
                    formFillColor: MyColors.white,
                    haveBorder: true,
                    isFormEnabled: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Item name is empty';
                      } else if (value.length < 3) {
                        return 'Enter a valid name';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: customFormField(
                    context: context,
                    labelText: 'Count',
                    controller: _itemStockController,
                    formFillColor: MyColors.white,
                    haveBorder: true,
                    isFormEnabled: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Item name is empty';
                      } else if (value.length < 3) {
                        return 'Enter a valid name';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: MyColors.white,
        child: Row(
          children: [
            Expanded(
              child: buttonAddSale(
                text: 'Save&New',
                haveBorder: true,
                btnColor: MyColors.transparent,
                //todo: Add function to save data
                onTap: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (ctx) => AddNewItemInSale())),
              ),
            ),
            Expanded(
              child: buttonAddSale(
                text: 'Save',

                //todo: Add function to save data
                onTap: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
