import 'dart:io';

import 'package:flutter/material.dart';
import 'package:inventory_management_app/constants/colors.dart';
import 'package:inventory_management_app/constants/font_styles.dart';
import 'package:inventory_management_app/constants/screen_size.dart';
import 'package:inventory_management_app/functions/format_money.dart';
import 'package:inventory_management_app/models/item_model.dart';
import 'package:inventory_management_app/screens/sub_screens/item_full_details_screen.dart';

class ItemDetailsForHome extends StatefulWidget {
  const ItemDetailsForHome({super.key});

  @override
  State<ItemDetailsForHome> createState() => _ItemDetailsForHomeState();
}

class _ItemDetailsForHomeState extends State<ItemDetailsForHome> {

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: filteredItemModelList,
      builder: (BuildContext context, List<ItemModel> itemModelList, _) =>
          (filteredItemModelList.value.isEmpty)
              ? SliverToBoxAdapter(
                  child: Container(
                    width: double.infinity,
                    height: MyScreenSize.screenHeight * .4,
                    alignment: AlignmentDirectional.center,
                    child: const Text('No item found'),
                  ),
                )
              : SliverGrid.builder(
                  itemCount: itemModelList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 15),
                  itemBuilder: (BuildContext context, int index) {
                    final itemModel = itemModelList[index];
                    return Center(
                      child: GridTile(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ItemFullDetails(
                                  itemModel: itemModel,
                                  brandId: itemModel.brandId,
                                ),
                              ));
                            },
                            child: Container(
                              height: 125,
                              width: MyScreenSize.screenWidth * 0.37,
                              decoration: BoxDecoration(
                                color: MyColors.lightGrey,
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(13),
                                child: Image.file(
                                  File(itemModel.itemImage),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                              child: Text(
                            itemModel.itemName,
                            style: MyFontStyle.itemNameInMain,
                            overflow: TextOverflow.ellipsis,
                          )),
                          Text(
                            formatMoney(number: itemModel.itemPrice),
                            style: MyFontStyle.itemPriceInMain,
                          ),
                        ],
                      )),
                    );
                  },
                ),
    );
  }
}
