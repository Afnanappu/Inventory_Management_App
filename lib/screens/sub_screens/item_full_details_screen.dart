import 'dart:io';

import 'package:flutter/material.dart';
import 'package:inventory_management_app/constants/colors.dart';
import 'package:inventory_management_app/constants/font_styles.dart';
import 'package:inventory_management_app/constants/screen_size.dart';
import 'package:inventory_management_app/database/brand_fun.dart';
import 'package:inventory_management_app/models/item_model.dart';
import 'package:inventory_management_app/screens/main_screens/item/add_or_edit_new_item.dart';
import 'package:inventory_management_app/widgets/appbar/app_bar_for_item_full_details.dart';
import 'package:inventory_management_app/widgets/button_add_sale.dart';

// ignore: must_be_immutable
class ItemFullDetails extends StatefulWidget {
  final ItemModel itemModel;
  final int brandId;
  ItemFullDetails({super.key, required this.itemModel, required this.brandId});

  @override
  State<ItemFullDetails> createState() => _ItemFullDetailsState();
}

class _ItemFullDetailsState extends State<ItemFullDetails> {
  String rams = '';

  String roms = '';

  ItemBrandModel? brand;

  void getBrand() async {
    brand = await findItemBrandFromDB(widget.brandId);
    setState(() {});
  }

  void _listToString() {
    for (var ram in widget.itemModel.ram) {
      rams = '$rams${ram}GB, ';
    }
    rams = rams.substring(0, rams.length - 2);
    for (var rom in widget.itemModel.rom) {
      roms = '$roms${rom}GB, ';
    }
    roms = roms.substring(0, roms.length - 2);
  }

  @override
  void initState() {
    getBrand();
    _listToString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Stack(
            children: [
              Container(
                color: MyColors.lightGrey,
                height: MyScreenSize.screenHeight * 0.5,
                child: Center(
                    child: SizedBox(
                  height: MyScreenSize.screenHeight * 0.3,
                  child: Image.file(
                    File(widget.itemModel.itemImage),
                  ),
                )),
              ),
              PreferredSize(
                preferredSize: const Size(double.maxFinite, 60),
                child: AppBarForItemFullDetails(onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => ItemAddNew(
                        itemModel: widget.itemModel,
                        isAddingItem: false,
                      ),
                    ),
                  );
                  print('item edit page is opened');
                }),
              ),
            ],
          ),
          Stack(
            children: [
              FractionalTranslation(
                translation: const Offset(0, -0.031),
                child: Container(
                  width: MyScreenSize.screenWidth,
                  decoration: const BoxDecoration(
                    color: MyColors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(28),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //item name
                        Text(
                          widget.itemModel.itemName,
                          style: const TextStyle(
                            color: MyColors.blackShade,
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        //item stock
                        Text(
                          (widget.itemModel.stock > 5)
                              ? '${widget.itemModel.stock} items'
                              : 'Only ${widget.itemModel.stock} item left',
                          style: TextStyle(
                            color: (widget.itemModel.stock > 5)
                                ? MyColors.green
                                : MyColors.red,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        //item description
                        Text(
                          widget.itemModel.description,
                          style: const TextStyle(
                            color: MyColors.blackShade,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),

                        //specification
                        const Text(
                          'Specification',
                          style: TextStyle(
                            color: MyColors.blackShade,
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),

                        SizedBox(
                          child: Column(
                            children: [
                              //Brand name
                              Row(
                                children: [
                                  const Expanded(
                                      child: Text(
                                    'Brand Name',
                                    style: MyFontStyle.mediumLightGrey,
                                  )),
                                  Expanded(
                                    child: Text(
                                      brand?.itemBrandName ?? 'Null',
                                      style: MyFontStyle.mediumBlackShade,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(
                                height: 10,
                              ),

                              //Brand name
                              Row(
                                children: [
                                  const Expanded(
                                      child: Text(
                                    'Model Name',
                                    style: MyFontStyle.mediumLightGrey,
                                  )),
                                  Expanded(
                                    child: Text(
                                      widget.itemModel.itemName,
                                      style: MyFontStyle.mediumBlackShade,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(
                                height: 10,
                              ),

                              //Color
                              Row(
                                children: [
                                  const Expanded(
                                      child: Text(
                                    'Color',
                                    style: MyFontStyle.mediumLightGrey,
                                  )),
                                  Expanded(
                                    child: Text(
                                      widget.itemModel.color.join(','),
                                      style: MyFontStyle.mediumBlackShade,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(
                                height: 10,
                              ),

                              //Ram
                              Row(
                                children: [
                                  const Expanded(
                                      child: Text(
                                    'RAM',
                                    style: MyFontStyle.mediumLightGrey,
                                  )),
                                  Expanded(
                                    child: Text(
                                      rams,
                                      style: MyFontStyle.mediumBlackShade,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(
                                height: 10,
                              ),

                              //Storage
                              Row(
                                children: [
                                  const Expanded(
                                      child: Text(
                                    'Storage',
                                    style: MyFontStyle.mediumLightGrey,
                                  )),
                                  Expanded(
                                    child: Text(
                                      roms,
                                      style: MyFontStyle.mediumBlackShade,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: MyScreenSize.screenWidth,
            height: 70,
            decoration: const BoxDecoration(
              color: MyColors.white,
              border: Border(
                top: BorderSide(color: MyColors.darkGrey),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    '₹${widget.itemModel.itemPrice}',
                    style: const TextStyle(
                      color: MyColors.blackShade,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: buttonAddSale(text: 'Add new sale', onTap: () {}),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
