import 'package:flutter/material.dart';
import 'package:inventory_management_app/constants/colors.dart';
import 'package:inventory_management_app/functions/format_money.dart';
import 'package:inventory_management_app/screens/sub_screens/add_new_sale.dart';

class TotalAmountSectionForSaleAddItemScreen extends StatelessWidget {
  const TotalAmountSectionForSaleAddItemScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Total Amount',
          style: TextStyle(
              color: MyColors.blackShade,
              fontSize: 18,
              fontWeight: FontWeight.w600),
        ),

        //total amount price
        Container(
          constraints: const BoxConstraints(maxWidth: 180, minWidth: 100),
          decoration: const BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: MyColors.blackShade, style: BorderStyle.solid))),
          child: ListTile(
            leading: const Text('₹',
                style: TextStyle(
                    color: MyColors.blackShade,
                    fontSize: 18,
                    fontWeight: FontWeight.w600)),
            title: ValueListenableBuilder(
              valueListenable: totalAmountNotifier,
              builder: (context, value, child) => SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Text(
                      formatMoney(number: value, haveSymbol: false),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: MyColors.blackShade,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
