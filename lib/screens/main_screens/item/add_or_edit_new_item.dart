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
  const ItemAddNew({
    super.key,
    this.itemModel,
    this.isAddingItem = true,
    this.removeBelowRoute = true,
  });
  final ItemModel? itemModel;
  final bool isAddingItem;
  final bool removeBelowRoute;

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

  int nowBrandId = 0;

  @override
  void initState() {
    if (widget.itemModel != null) {
      nowBrandId = widget.itemModel!.brandId;

      image = widget.itemModel!.itemImage;

      _itemNameController.text = widget.itemModel!.itemName;
      _itemPriceController.text = widget.itemModel!.itemPrice.toString();
      _itemStockController.text = widget.itemModel!.stock.toString();
      _itemColorController.text = widget.itemModel!.color.join(', ');
      _itemRamController.text = widget.itemModel!.ram.join(', ');
      _itemStorageController.text = widget.itemModel!.rom.join(', ');
      _itemDescriptionController.text = widget.itemModel!.description;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.maxFinite, 60),
        child: AppBarForSubWithEdit(
          title: (widget.isAddingItem == true) ? 'Add Item' : 'Edit Item',
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
                                  fit: BoxFit.contain)
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
                        return 'item name is empty, provide a name';
                      } else {
                        return null;
                      }
                    },
                  ),

                  //brand (drop drown button)
                  ValueListenableBuilder(
                    valueListenable: itemBrandListNotifiers,
                    builder: (context, itemBrand, child) => DropDownForAll(
                      nowValue: nowBrandId,
                      validator: (value) {
                        if (value == null) {
                          return 'No brand is selected, select one';
                        } else {
                          return null;
                        }
                      },
                      items: itemBrand.map(
                        (e) {
                          return DropdownMenuItem(
                            value: e.id,
                            child: Text(e.itemBrandName),
                          );
                        },
                      ).toList(),
                      onChanged: (e) {
                        setState(() {
                          nowBrandId = e;
                        });
                      }, hintText: 'Select brand',
                    ),
                  ),

                  //price
                  customFormField(
                    context: context,
                    labelText: 'Price',
                    controller: _itemPriceController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'item price is empty, provide a price';
                      } else {
                        return null;
                      }
                    },
                  ),

                  //stock count
                  customFormField(
                    vPadding: 0,
                    context: context,
                    labelText: 'Stock Count',
                    controller: _itemStockController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'item stock count is empty, provide a stock count';
                      } else {
                        return null;
                      }
                    },
                  ),

                  //color
                  customFormField(
                    context: context,
                    labelText: 'Color',
                    controller: _itemColorController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'item have no color!, try to provide';
                      } else {
                        return null;
                      }
                    },
                  ),

                  //ram
                  customFormField(
                    vPadding: 0,
                    context: context,
                    labelText: 'Ram',
                    controller: _itemRamController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'item have no ram!, try to provide';
                      } else {
                        return null;
                      }
                    },
                  ),

                  //storage
                  customFormField(
                    context: context,
                    labelText: 'Storage',
                    controller: _itemStorageController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'item have no storage!, try to provide';
                      } else {
                        return null;
                      }
                    },
                  ),

                  //description
                  customFormField(
                    vPadding: 0,
                    context: context,
                    labelText: 'Description',
                    controller: _itemDescriptionController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'item description is empty, provide description';
                      } else {
                        return null;
                      }
                    },
                  ),

                  //---------- Save button ----------//
                  MyButton(
                    vPadding: 5,
                    color: MyColors.green,
                    text: (widget.isAddingItem == true)
                        ? 'Add to items'
                        : 'Save Changes',
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
                              brandId: nowBrandId,
                              itemName: _itemNameController.text,
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
