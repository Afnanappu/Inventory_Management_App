import 'dart:io';
import 'package:flutter/material.dart';
import 'package:inventory_management_app/constants/colors.dart';
import 'package:inventory_management_app/constants/screen_size.dart';
import 'package:inventory_management_app/database/item_fun.dart';
import 'package:inventory_management_app/functions/pick_image.dart';
import 'package:inventory_management_app/models/item_model.dart';
import 'package:inventory_management_app/widgets/appbar/app_bar_for_sub_with_edit.dart';
import 'package:inventory_management_app/widgets/buttons.dart';
import 'package:inventory_management_app/widgets/drop_down_for_all.dart';
import 'package:inventory_management_app/widgets/snack_bar_messenger.dart';
import 'package:inventory_management_app/widgets/text_form_field.dart';

class ItemAddNew extends StatefulWidget {
  const ItemAddNew({super.key});

  @override
  State<ItemAddNew> createState() => _ItemAddNewState();
}

class _ItemAddNewState extends State<ItemAddNew> {
  final _itemNameController = TextEditingController();

  final _itemPriceController = TextEditingController();

  final _itemStockController = TextEditingController();

  final _itemColorController = TextEditingController();

  final _itemRamController = TextEditingController();

  final _itemStorageController = TextEditingController();

  final _itemDescriptionController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String? image;

  String nowBrandName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.maxFinite, 60),
        child: AppBarForSubWithEdit(
          title: 'Add Item',
          isAddIcon: false,
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  InkWell(
                    onTap: () async {
                      await pickImageFromFile().then(
                        (value) {
                          image = value;
                        },
                      );
                      setState(() {});
                    },

                    //image
                    child: Container(
                      height: MyScreenSize.screenHeight * 0.4,
                      width: MyScreenSize.screenWidth * 0.8,
                      decoration: BoxDecoration(
                          image: (image != null)
                              ? DecorationImage(
                                  image: FileImage(File(image!)),
                                  fit: BoxFit.cover)
                              : null,
                          color: MyColors.lightGrey,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                          child:
                              (image == null) ? const Text('add image') : null),
                    ),
                  ),

                  //Item name
                  customFormField(
                    context: context,
                    labelText: 'Item name',
                    controller: _itemNameController,
                    vPadding: 20,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'item name is empty, provide any name';
                      } else {
                        return null;
                      }
                    },
                  ),

                  //brand (drop drown button)
                  ValueListenableBuilder(
                    valueListenable: itemBrandListNotifiers,
                    builder: (context, itemBrand, child) => DropDownForAll(
                      items: itemBrand.map(
                        (e) {
                          return DropdownMenuItem(
                            value: e.itemBrandName,
                            child: Text(e.itemBrandName),
                          );
                        },
                      ).toList(),
                      onChanged: (e) {
                        nowBrandName = e;
                      },
                    ),
                  ),

                  //price
                  customFormField(
                      context: context,
                      labelText: 'Price',
                      controller: _itemPriceController,
                      keyboardType: TextInputType.number),

                  //stock count
                  customFormField(
                      vPadding: 0,
                      context: context,
                      labelText: 'Stock Count',
                      controller: _itemStockController,
                      keyboardType: TextInputType.number),

                  //color
                  customFormField(
                    context: context,
                    labelText: 'Color',
                    controller: _itemColorController,
                  ),

                  //ram
                  customFormField(
                      vPadding: 0,
                      context: context,
                      labelText: 'Ram',
                      controller: _itemRamController,
                      keyboardType: TextInputType.number),

                  //storage
                  customFormField(
                    context: context,
                    labelText: 'Storage',
                    controller: _itemStorageController,
                    keyboardType: TextInputType.number,
                  ),

                  //description
                  customFormField(
                    vPadding: 0,
                    context: context,
                    labelText: 'Description',
                    controller: _itemDescriptionController,
                  ),

                  //---------- Save button ----------//
                  MyButton(
                    vPadding: 5,
                    color: MyColors.green,
                    text: 'Add to items',
                    function: () {
                      try {
                        if (_formKey.currentState!.validate()) {
                          if (image == null) {
                            CustomSnackBarMessage(
                                context: context,
                                message:
                                    'Image is not added, please add image!',
                                color: MyColors.red);
                          } else {
                            final item = ItemModel(
                              itemName: _itemNameController.text,
                              itemBrand: nowBrandName,
                              itemImage: image!,
                              itemPrice:
                                  double.parse(_itemPriceController.text),
                              color: [..._itemColorController.text.split(',')],
                              ram: [..._itemRamController.text.split(',')],
                              rom: [..._itemStorageController.text.split(',')],
                              description: _itemDescriptionController.text,
                              stock: int.parse(
                                _itemStockController.text,
                              ),
                            );

                            addItemToDB(item);
                            CustomSnackBarMessage(
                                context: context,
                                message: 'Item added successfully',
                                color: MyColors.green);
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
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
