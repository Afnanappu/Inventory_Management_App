import 'package:flutter/material.dart';
import 'package:inventory_management_app/constants/colors.dart';
import 'package:inventory_management_app/constants/font_styles.dart';
import 'package:inventory_management_app/constants/screen_size.dart';
import 'package:inventory_management_app/models/item_model.dart';

class ItemDetailsForHome extends StatelessWidget {
  const ItemDetailsForHome({super.key});


  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
      valueListenable: itemModelList,
      builder: (BuildContext context,List<ItemModel>  item, Widget? child) => SliverGrid.builder(
        itemCount: item.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2 ,crossAxisSpacing: 0,mainAxisSpacing: 15),
        itemBuilder: (BuildContext context, int index) {
          final itemModel = item[index];
          return Center(
            child: GridTile(
              
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 125,
                  width: MyScreenSize.screenWidth * 0.37,
                  decoration: BoxDecoration(
                    color: MyColors.lightGrey,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Padding(
                    padding: const  EdgeInsets.all(13),
                    child: Image.asset(
                      itemModel.itemImage,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Text(itemModel.itemName,style: MyFontStyle.itemNameInMain),
                Text(itemModel.itemPrice, style: MyFontStyle.itemPriceInMain,),
              ],
            )),
          );
        },
      ),
    );
  }
}
