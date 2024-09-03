import 'package:flutter/material.dart';
import 'package:inventory_management_app/constants/colors.dart';
import 'package:inventory_management_app/constants/screen_size.dart';
import 'package:inventory_management_app/database/brand_fun.dart';
import 'package:inventory_management_app/database/customer_fun.dart';
import 'package:inventory_management_app/database/item_fun.dart';
import 'package:inventory_management_app/database/sales_fun.dart';
import 'package:inventory_management_app/functions/date_time_functions.dart';
import 'package:inventory_management_app/functions/format_money.dart';
import 'package:inventory_management_app/models/customer_model.dart';
import 'package:inventory_management_app/models/item_model.dart';
import 'package:inventory_management_app/screens/sub_screens/add_new_sale.dart';
import 'package:inventory_management_app/widgets/appbar/app_bar_for_sub_with_edit.dart';
import 'package:inventory_management_app/widgets/custom_container.dart';
import 'package:inventory_management_app/widgets/dropdown_for_dashboard.dart';
import 'package:inventory_management_app/widgets/sale_list_tile.dart';

class AllSaleDataScreen extends StatelessWidget {
  AllSaleDataScreen({super.key});

  final ValueNotifier<String?> _selectedValue = ValueNotifier(list[0]);

  final ValueNotifier<DateTime> pickedStartDateNotifier =
      ValueNotifier(getTheCurrentDateStartOrEnd(currentDate: CurrentDate.week));
  final ValueNotifier<DateTime> pickedEndDateNotifier = ValueNotifier(
      getTheCurrentDateStartOrEnd(currentDate: CurrentDate.week, start: false));

  Future<void> _loadData() async {
    await getAllCustomersFormDB();
    await getAllSalesFromDB();
    getTheCurrentDate(CurrentDate.week);
  }

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
      body: ListView(
        children: [
          //divider
          const Divider(),

          //filter
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  //dropdown
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
                        pickedStartDateNotifier.value =
                            getTheCurrentDateStartOrEnd(
                                currentDate: CurrentDate.week);
                        pickedEndDateNotifier.value =
                            getTheCurrentDateStartOrEnd(
                                currentDate: CurrentDate.week, start: false);
                      } else if (_selectedValue.value == list[1]) {
                        getTheCurrentDate(CurrentDate.month);
                        pickedStartDateNotifier.value =
                            getTheCurrentDateStartOrEnd(
                                currentDate: CurrentDate.month);
                        pickedEndDateNotifier.value =
                            getTheCurrentDateStartOrEnd(
                                currentDate: CurrentDate.month, start: false);
                      } else {
                        getTheCurrentDate(CurrentDate.year);
                        pickedStartDateNotifier.value =
                            getTheCurrentDateStartOrEnd(
                                currentDate: CurrentDate.year);
                        pickedEndDateNotifier.value =
                            getTheCurrentDateStartOrEnd(
                                currentDate: CurrentDate.year, start: false);
                      }
                    },
                  ),
                ),

                //divider
                const VerticalDivider(
                  color: MyColors.lightGrey,
                  thickness: 1.5,
                  width: 15,
                  indent: 10,
                  endIndent: 10,
                ),

                //Date
                Row(
                  children: [
                    //Date From
                    IconButton(
                      onPressed: () async {
                        final pickedDate = await pickDateFromUser(
                            context: context,
                            initialDate: pickedStartDateNotifier.value);
                        if (pickedDate != null) {
                          pickedStartDateNotifier.value = pickedDate;
                          getSalesBasedOnDateTime(
                              startDate: pickedDate,
                              endDate: pickedEndDateNotifier.value);
                          getTheNumberOfItemSold(
                            start: pickedDate,
                            end: pickedEndDateNotifier.value,
                          );
                          getThePriceAmountOfItemSold(
                            start: pickedDate,
                            end: pickedEndDateNotifier.value,
                          );
                        }
                      },
                      icon: Row(
                        children: [
                          const Icon(Icons.calendar_month_outlined),
                          const SizedBox(
                            width: 10,
                          ),
                          ValueListenableBuilder(
                            valueListenable: pickedStartDateNotifier,
                            builder: (context, value, child) => Text(
                              formatDateTime(date: value),
                              style: const TextStyle(
                                  color: MyColors.blackShade,
                                  fontWeight: FontWeight.w600),
                            ),
                          )
                        ],
                      ),
                    ),

                    const Text(
                      'TO',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),

                    //Date To
                    TextButton(
                      style: ButtonStyle(
                          foregroundColor: WidgetStateColor.resolveWith(
                        (_) => MyColors.blackShade,
                      )),
                      onPressed: () async {
                        final pickedDate = await pickDateFromUser(
                            context: context,
                            initialDate: pickedEndDateNotifier.value);
                        if (pickedDate != null) {
                          pickedEndDateNotifier.value = pickedDate;
                          getSalesBasedOnDateTime(
                            startDate: pickedStartDateNotifier.value,
                            endDate: pickedDate,
                          );

                          getTheNumberOfItemSold(
                            start: pickedStartDateNotifier.value,
                            end: pickedDate,
                          );
                          getThePriceAmountOfItemSold(
                            start: pickedStartDateNotifier.value,
                            end: pickedDate,
                          );
                        }
                      },
                      child: ValueListenableBuilder(
                        valueListenable: pickedEndDateNotifier,
                        builder: (context, value, child) => Text(
                          formatDateTime(date: value),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),

          //divider
          const Divider(),

          Padding(
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
          ),

          //list builder
          FutureBuilder(
            future: _loadData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else {
                return (dateTimeFilterNotifier.value.isEmpty)
                    ? const Center(
                        child: Text('No sale is added'),
                      )
                    : ValueListenableBuilder(
                        valueListenable: dateTimeFilterNotifier,
                        builder: (BuildContext context,
                            List<CustomerModel> customers, _) {
                          customers = customers.reversed.toList();
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: customers.length,
                            itemBuilder: (context, index) {
                              final customer = customers[index];
                              final sale =
                                  getSaleFromFromDB(customer.saleId.first);
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
            },
          ),
        ],
      ),
    );
  }
}
