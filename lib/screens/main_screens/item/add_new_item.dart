import 'dart:io';
import 'package:flutter/material.dart';
import 'package:inventory_management_app/constants/colors.dart';
import 'package:inventory_management_app/constants/screen_size.dart';
import 'package:inventory_management_app/database/add_item.dart';
import 'package:inventory_management_app/functions/pick_image.dart';
import 'package:inventory_management_app/models/item_model.dart';
import 'package:inventory_management_app/widgets/appbar/app_bar_for_sub_with_edit.dart';
import 'package:inventory_management_app/widgets/buttons.dart';
import 'package:inventory_management_app/widgets/drop_down_for_all.dart';
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
                customFormField(
                    context: context,
                    labelText: 'Item name',
                    controller: _itemNameController,
                    vPadding: 20),
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
                // customFormField(
                //   context: context,
                //   labelText: 'Item brand',
                //   controller: _itemBrandController,
                //   vPadding: 0,
                // ),
                customFormField(
                    context: context,
                    labelText: 'Price',
                    controller: _itemPriceController,
                    keyboardType: TextInputType.number),
                customFormField(
                    vPadding: 0,
                    context: context,
                    labelText: 'Stock Count',
                    controller: _itemStockController,
                    keyboardType: TextInputType.number),
                customFormField(
                  context: context,
                  labelText: 'Color',
                  controller: _itemColorController,
                ),
                customFormField(
                    vPadding: 0,
                    context: context,
                    labelText: 'Ram',
                    controller: _itemRamController,
                    keyboardType: TextInputType.number),
                customFormField(
                  context: context,
                  labelText: 'Storage',
                  controller: _itemStorageController,
                  keyboardType: TextInputType.number,
                ),
                customFormField(
                  context: context,
                  labelText: 'Description',
                  controller: _itemDescriptionController,
                ),

                //---------- Save button ----------//
                MyButton(
                  color: MyColors.green,
                  text: 'Add to items',
                  function: () {
                    final item = ItemModel(
                      itemName: _itemNameController.text,
                      itemBrand: nowBrandName,
                      itemImage: image!,
                      itemPrice: double.parse(_itemPriceController.text),
                      color: [ItemCOLOR.Black],
                      ram: [ItemRAM.GB4],
                      rom: [ItemROM.GB64],
                      description: _itemDescriptionController.text,
                      stock: int.parse(
                        _itemStockController.text,
                      ),
                    );

                    addItemToDB(item);

                    // itemAddToItemBrand(ItemBrandModel(
                    //     itemBrandName: itemBrandModel.itemBrandName,
                    //     itemModelList: itemBrandModel.itemModelList));
                    // print('${itemBrandModel.itemBrandName}: ${ _itemNameController.text}');
                    Navigator.of(context).pop();
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
    );
  }
}
