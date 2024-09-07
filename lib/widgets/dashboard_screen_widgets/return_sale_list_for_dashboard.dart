import 'package:flutter/material.dart';
import 'package:inventory_management_app/database/customer_fun.dart';
import 'package:inventory_management_app/database/item_fun.dart';
import 'package:inventory_management_app/database/sales_fun.dart';
import 'package:inventory_management_app/models/customer_model.dart';
import 'package:inventory_management_app/widgets/dashboard_screen_widgets/all_sale_screen_widgets/return_list_tile.dart';

class ReturnSaleListForDashboard extends StatelessWidget {
  const ReturnSaleListForDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: returnItemsListNotifier,
      builder: (context, value, child) {
        return value.isNotEmpty
            ? SliverList.builder(
                itemCount: (value.length<4)?value.length:4,
                itemBuilder: (context, index) {
                  final returnItem = value[index];
                  final customer =
                      getCustomerFromDB(returnItem.customerId);
                  final saleItem = getSaleFromDB(returnItem.saleId);
                  final item = getItemFromDB(saleItem.itemId);
                  // final brand = getItemBrandFromDB(item.brandId);
                  return SaleListTile(
                    image: item.itemImage,
                    customerName: item.itemName,
                    invoiceNo: '${index + 1}',
                    brandName: customer.customerName,
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
