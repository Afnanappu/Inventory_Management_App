
import 'package:flutter/material.dart';
import 'package:inventory_management_app/database/brand_fun.dart';
import 'package:inventory_management_app/database/item_fun.dart';
import 'package:inventory_management_app/database/sales_fun.dart';
import 'package:inventory_management_app/functions/format_money.dart';
import 'package:inventory_management_app/models/customer_model.dart';
import 'package:inventory_management_app/screens/sub_screens/add_new_sale.dart';
import 'package:inventory_management_app/widgets/dashboard_screen_widgets/sale_list_tile.dart';

class CustomerListForDashboard extends StatelessWidget {
  const CustomerListForDashboard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: customerListNotifier,
        builder: (BuildContext context,
            List<CustomerModel> customers, _) {
          return SliverList.builder(
            itemCount:
                (customers.length < 4) ? customers.length : 4,
            itemBuilder: (context, index) {
              final customerRev = customers.reversed.toList();
              final customer = customerRev[index];
              final sale =
                  getSaleFromFromDB(customer.saleId.first);
              final item = getItemFromDB(sale.itemId);
              final brand = getItemBrandFromDB(item.brandId);
              final sumOfSales = getSumOfAllSaleOfOneCustomer(
                  customer.saleId);
              return SaleListTile(
                image: item.itemImage,
                customerName: customer.customerName,
                invoiceNo: '${customers.length - index}',
                brandName: brand.itemBrandName,
                itemPrice: formatMoney(number: sumOfSales),
                saleAddDate: customer.saleDateTime,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SaleAddNew(
                        customer: customer,
                        isViewer: true,
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      );
  }
}