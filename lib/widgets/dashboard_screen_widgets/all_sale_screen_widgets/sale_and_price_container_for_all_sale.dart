import 'package:flutter/widgets.dart';
import 'package:inventory_management_app/constants/screen_size.dart';
import 'package:inventory_management_app/functions/format_money.dart';
import 'package:inventory_management_app/models/item_model.dart';
import 'package:inventory_management_app/widgets/common/custom_container.dart';

class SalesAndPriceContainerForAllSale extends StatelessWidget {
  const SalesAndPriceContainerForAllSale({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          //item box
          ValueListenableBuilder(
              valueListenable: numberOfItemSoldListNotifier,
              builder: (context, value, child) => CustomContainer(
                    haveBgColor: false,
                    title: 'No. of item sold',
                    subtitle: '$value',
                    height: MyScreenSize.screenWidth * 0.3,
                  )),
    
          //sale box
          ValueListenableBuilder(
            valueListenable: priceAmountOfItemSoldListNotifier,
            builder: (context, value, child) => CustomContainer(
              title: 'Total sale',
              height: MyScreenSize.screenWidth * 0.3,
              subtitle: formatMoney(
                number: value,
                haveEndSymbol: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
