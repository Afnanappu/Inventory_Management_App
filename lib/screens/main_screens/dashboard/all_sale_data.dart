import 'package:flutter/material.dart';
import 'package:inventory_management_app/constants/colors.dart';
import 'package:inventory_management_app/database/brand_fun.dart';
import 'package:inventory_management_app/database/item_fun.dart';
import 'package:inventory_management_app/database/sales_fun.dart';
import 'package:inventory_management_app/functions/date_time_functions.dart';
import 'package:inventory_management_app/functions/format_money.dart';
import 'package:inventory_management_app/models/customer_model.dart';
import 'package:inventory_management_app/screens/main_screens/dashboard/dashboard_screen.dart';
import 'package:inventory_management_app/widgets/appbar/app_bar_for_sub_with_edit.dart';
import 'package:inventory_management_app/widgets/sale_list_tile.dart';

class AllSaleDataScreen extends StatelessWidget {
  AllSaleDataScreen({super.key});

  final ValueNotifier<String?> _selectedValue = ValueNotifier(list[0]);

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
      body: ListView(children: [
        Row(
          children: [
            Expanded(
              child: DropdownButtonFormField(
                dropdownColor: MyColors.white,
                padding: const EdgeInsets.only(left: 20),
                value: _selectedValue.value,
                decoration: const InputDecoration(border: InputBorder.none),
                items: list.map(
                  (e) {
                    return DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    );
                  },
                ).toList(),
                onChanged: (value) {
                  _selectedValue.value = value;
                  if (_selectedValue.value == list[0]) {
                    getTheCurrentDate(CurrentDate.week);
                  } else if (_selectedValue.value == list[1]) {
                    getTheCurrentDate(CurrentDate.month);
                  } else {
                    getTheCurrentDate(CurrentDate.year);
                  }

                },
              ),
            ),
          ],
        ),
        (dateTimeFilterNotifier.value.isEmpty)
            ? const Center(
                child: Text('No sale is added'),
              )
            : ValueListenableBuilder(
                valueListenable: dateTimeFilterNotifier,
                builder:
                    (BuildContext context, List<CustomerModel> customers, _) {
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
                      final sumOfSales =
                          getSumOfAllSaleOfOneCustomer(customer.saleId);
                      return SaleListTile(
                        image: item.itemImage,
                        customerName: customer.customerName,
                        invoiceNo: '${customers.length - index}',
                        brandName: brand.itemBrandName,
                        itemPrice: formatMoney(number: sumOfSales),
                        saleAddDate: customer.saleDateTime,
                      );
                    },
                  );
                },
              ),
      ]),
    );
  }
}
