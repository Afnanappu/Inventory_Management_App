import 'package:flutter/material.dart';
import 'package:inventory_management_app/constants/colors.dart';
import 'package:inventory_management_app/constants/font_styles.dart';
import 'package:inventory_management_app/constants/screen_size.dart';
import 'package:inventory_management_app/database/add_item.dart';
import 'package:inventory_management_app/models/item_model.dart';
import 'package:inventory_management_app/screens/sub_screens/item_full_details_screen.dart';

class ItemDetailsForHome extends StatelessWidget {
  const ItemDetailsForHome({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: itemModelListNotifiers,
      builder: (BuildContext context, List<ItemModel> itemModelList, _) =>
          SliverGrid.builder(
        itemCount: itemModelList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 0, mainAxisSpacing: 15),
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
                        image: itemModel.itemImage,
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
                      child: Image.asset(
                        itemModel.itemImage,
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
                  '${itemModel.itemPrice}',
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
