import 'package:flutter/material.dart';
import 'package:inventory_management_app/database/item_fun.dart';
import 'package:inventory_management_app/models/customer_model.dart';
import 'package:inventory_management_app/widgets/dashboard_screen_widgets/all_sale_screen_widgets/return_list_tile.dart';

class ReturnSaleListForDashboard extends StatelessWidget {
  const ReturnSaleListForDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: returnItemsListNotifier,
      builder: (context, value, child) {
        final reversedReturnSales = value.reversed.toList();
        final len = value.length;
        return value.isNotEmpty
            ? SliverList.builder(
                itemCount: (len < 4) ? len : 4,
                itemBuilder: (context, index) {
                  final returnItem = reversedReturnSales[index];
                  final item = getItemFromDB(returnItem.itemId);
                  return SaleListTile(
                    image: item.itemImage,
                    customerName: item.itemName,
                    invoiceNo: '${len- index}',
                    brandName: returnItem.customerName,
                    itemPrice: '${item.itemPrice}',
                    saleAddDate: returnItem.dateTime,
                    onTap: () {},
                  );
                },
              )
            : const SliverToBoxAdapter(
                child: Center(
                  child: Text('No Return item'),
                ),
              );
      },
    );
  }
}
