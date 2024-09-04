import 'package:flutter/material.dart';
import 'package:inventory_management_app/constants/colors.dart';
import 'package:inventory_management_app/database/item_fun.dart';
import 'package:inventory_management_app/models/item_model.dart';
import 'package:inventory_management_app/screens/sub_screens/add_or_edit_new_item_screen.dart';
import 'package:inventory_management_app/widgets/common/buttons.dart';
import 'package:inventory_management_app/widgets/common/snack_bar_messenger.dart';

class ButtonForAddOrEditItemScreen extends StatelessWidget {
  const ButtonForAddOrEditItemScreen({
    super.key,
    required this.widget,
    required GlobalKey<FormState> formKey,
    required this.imageNotifier,
    required this.nowBrandId,
    required TextEditingController itemNameController,
    required TextEditingController itemPriceController,
    required TextEditingController itemColorController,
    required TextEditingController itemRamController,
    required TextEditingController itemStorageController,
    required TextEditingController itemDescriptionController,
    required TextEditingController itemStockController,
  })  : _formKey = formKey,
        _itemNameController = itemNameController,
        _itemPriceController = itemPriceController,
        _itemColorController = itemColorController,
        _itemRamController = itemRamController,
        _itemStorageController = itemStorageController,
        _itemDescriptionController = itemDescriptionController,
        _itemStockController = itemStockController;

  final ItemAddNew widget;
  final GlobalKey<FormState> _formKey;
  final ValueNotifier<String?> imageNotifier;
  final int? nowBrandId;
  final TextEditingController _itemNameController;
  final TextEditingController _itemPriceController;
  final TextEditingController _itemColorController;
  final TextEditingController _itemRamController;
  final TextEditingController _itemStorageController;
  final TextEditingController _itemDescriptionController;
  final TextEditingController _itemStockController;

  @override
  Widget build(BuildContext context) {
    return MyButton(
      vPadding: 5,
      color: MyColors.green,
      text: (widget.isAddingItem == true) ? 'Add to items' : 'Save Changes',
      function: () {
        try {
          if (_formKey.currentState!.validate()) {
            if (imageNotifier.value == null) {
              CustomSnackBarMessage(
                  context: context,
                  message: 'Image is not added, please add image!',
                  color: MyColors.red);
            } else {
              final item = ItemModel(
                id: (widget.itemModel != null) ? widget.itemModel!.id! : null,
                brandId: nowBrandId!,
                itemName: _itemNameController.text,
                itemImage: imageNotifier.value!,
                itemPrice: double.parse(_itemPriceController.text),
                color: [..._itemColorController.text.split(',')],
                ram: [..._itemRamController.text.split(',')],
                rom: [..._itemStorageController.text.split(',')],
                description: _itemDescriptionController.text,
                stock: int.parse(
                  _itemStockController.text,
                ),
              );
              if (widget.isAddingItem == true) {
                addItemToDB(item);
                CustomSnackBarMessage(
                    context: context,
                    message: 'Item added successfully',
                    color: MyColors.green);
              } else {
                editItemFromDB(widget.itemModel!.id!, item);
                if (widget.removeBelowRoute == true) {
                  Navigator.of(context)
                      .removeRouteBelow(ModalRoute.of(context)!);
                }
                CustomSnackBarMessage(
                    context: context,
                    message: 'Item edited successfully',
                    color: MyColors.green);
              }
              Navigator.of(context).pop();
            }
          }
        } catch (e) {
          CustomSnackBarMessage(
              context: context,
              message: 'Error while adding new item',
              color: MyColors.red);
        }
      },
    );
  }
}
