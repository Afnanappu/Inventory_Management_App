import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:inventory_management_app/constants/colors.dart';
import 'package:inventory_management_app/constants/font_styles.dart';
import 'package:inventory_management_app/widgets/buttons.dart';

class SaleListTile extends StatelessWidget {
  final String image;
  final String customerName;
  final String invoiceNo;
  final String brandName;
  final String itemPrice;
  final DateTime saleAddDate;
  const SaleListTile({
    super.key,
    required this.image,
    required this.customerName,
    required this.invoiceNo,
    required this.brandName,
    required this.itemPrice,
    required this.saleAddDate,
  });

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
          leading: Image.file(
            File(image),
            fit: BoxFit.contain,
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                customerName,
                style: MyFontStyle.saleTile,
              ),
              Text(
                '#$invoiceNo',
                style: MyFontStyle.saleTileInvoice,
              ),
            ],
          ),
          subtitle: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    brandName,
                    style: const TextStyle(
                        color: MyColors.darkGrey,
                        fontSize: 13,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    DateFormat('dd/MM/yy').format(saleAddDate),
                    style: MyFontStyle.saleTileInvoice,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    itemPrice,
                    style: MyFontStyle.saleTile,
                  ),
                  MyCustomButton(
                    color: const Color.fromARGB(146, 154, 255, 170),
                    text: 'SALE',
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
