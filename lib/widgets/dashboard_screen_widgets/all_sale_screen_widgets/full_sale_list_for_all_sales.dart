import 'package:flutter/material.dart';
import 'package:inventory_management_app/database/brand_fun.dart';
import 'package:inventory_management_app/database/item_fun.dart';
import 'package:inventory_management_app/database/sales_fun.dart';
import 'package:inventory_management_app/functions/format_money.dart';
import 'package:inventory_management_app/models/customer_model.dart';
import 'package:inventory_management_app/screens/sub_screens/add_new_sale.dart';
import 'package:inventory_management_app/widgets/sale_list_tile.dart';

class FullSaleListForAllSales extends StatelessWidget {
  const FullSaleListForAllSales({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: dateTimeFilterNotifier,
      builder: (BuildContext context, List<CustomerModel> customers, _) {
        customers = customers.reversed.toList();
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: customers.length,
          itemBuilder: (context, index) {
            final customer = customers[index];
            final sale = getSaleFromFromDB(customer.saleId.first);
            final item = getItemFromDB(sale.itemId);
            final brand = getItemBrandFromDB(item.brandId);
            final sumOfSales = getSumOfAllSaleOfOneCustomer(customer.saleId);
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
