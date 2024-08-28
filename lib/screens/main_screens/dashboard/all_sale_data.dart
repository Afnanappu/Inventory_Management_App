import 'package:flutter/material.dart';
import 'package:inventory_management_app/database/brand_fun.dart';
import 'package:inventory_management_app/database/item_fun.dart';
import 'package:inventory_management_app/database/sales_fun.dart';
import 'package:inventory_management_app/functions/format_money.dart';
import 'package:inventory_management_app/models/customer_model.dart';
import 'package:inventory_management_app/widgets/appbar/app_bar_for_sub_with_edit.dart';
import 'package:inventory_management_app/widgets/sale_list_tile.dart';

class AllSaleDataScreen extends StatelessWidget {
  const AllSaleDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.maxFinite, 60),
        child: AppBarForSubWithEdit(
          title: "All sales",
          isAddIcon: false,
        ),
      ),
      body: (customerListNotifier.value.isEmpty)
          ? const Center(child: Text('No sale is added'))
          : ValueListenableBuilder(
              valueListenable: customerListNotifier,
              builder:
                  (BuildContext context, List<CustomerModel> customers, _) {
                customers = customers.reversed.toList();
                return ListView.builder(
                  itemCount: customers.length,
                  itemBuilder: (context, index) {
                    final customer = customers[index];
                    final sale = getSaleFromFromDB(customer.saleId.first);
                    final item = getItemFromDB(sale.itemId);
                    final brand = getItemBrandFromDB(item.brandId);
                    final sumOfSales =
                        getSumOfAllSaleOfOneCustomer(customer.saleId);
                    return SaleListTile(
                      image: item.itemImage,
                      customerName: customer.customerName,
                      invoiceNo: customer.customerId.toString(),
                      brandName: brand.itemBrandName,
                      itemPrice: formatMoney(number: sumOfSales),
                      saleAddDate: customer.saleDateTime,
                    );
                  },
                );
              },
            ),
    );
  }
}
