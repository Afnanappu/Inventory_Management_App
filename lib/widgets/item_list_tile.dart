import 'package:flutter/material.dart';
import 'package:inventory_management_app/constants/colors.dart';
import 'package:inventory_management_app/constants/font_styles.dart';

class ItemListTile extends StatelessWidget {
  final String image;
  final String itemName;
  final String itemPrice;
  final String itemStock;

  const ItemListTile(
      {super.key,
      required this.image,
      required this.itemPrice,
      required this.itemName,
      required this.itemStock});

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
          leading: Image.asset(
            image,
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  itemName,
                  style: MyFontStyle.saleTile,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Icon(
                Icons.more_vert,
                color: MyColors.blackShade,
              ),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                '$itemStock in stock',
                style: const TextStyle(
                    color: MyColors.green,
                    fontSize: 13,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                itemPrice,
                style: MyFontStyle.saleTile,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
