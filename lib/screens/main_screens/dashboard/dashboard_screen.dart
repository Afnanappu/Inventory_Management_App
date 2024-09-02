import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management_app/constants/colors.dart';
import 'package:inventory_management_app/constants/font_styles.dart';
import 'package:inventory_management_app/constants/screen_size.dart';
import 'package:inventory_management_app/database/brand_fun.dart';
import 'package:inventory_management_app/database/customer_fun.dart';
import 'package:inventory_management_app/database/item_fun.dart';
import 'package:inventory_management_app/database/sales_fun.dart';
import 'package:inventory_management_app/functions/date_time_functions.dart';
import 'package:inventory_management_app/functions/format_money.dart';
import 'package:inventory_management_app/models/customer_model.dart';
import 'package:inventory_management_app/models/item_model.dart';
import 'package:inventory_management_app/models/profile_model.dart';
import 'package:inventory_management_app/screens/main_screens/dashboard/all_sale_data.dart';
import 'package:inventory_management_app/screens/main_screens/home/home_screen.dart';
import 'package:inventory_management_app/screens/sub_screens/add_new_sale.dart';
import 'package:inventory_management_app/widgets/appbar/app_bar_for_main.dart';
import 'package:inventory_management_app/widgets/custom_container.dart';
import 'package:inventory_management_app/widgets/sale_list_tile.dart';

// ignore: must_be_immutable
class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});

  ProfileModel? profile;

  final ValueNotifier<String?> _selectedValue = ValueNotifier(list[0]);

  final today = DateTime.now();

  Future<void> _fetchSaleData() async {
    await getAllCustomersFormDB();
    await getAllSalesFromDB();
    fun();
  }

  void fun() {
    getTheCurrentDate(CurrentDate.week);
    getGraphBasedOnSales(currentDate: CurrentDate.week);
  }

  // Future<void>
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.maxFinite, 60),
        child: AppBarForMain(
            title: HomeScreen.profileName,
            onPressed: () {
              Navigator.of(context).pushNamed("/NotificationScreen");
            }),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              //date select
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
                    getGraphBasedOnSales(currentDate: CurrentDate.week);
                  } else if (_selectedValue.value == list[1]) {
                    getTheCurrentDate(CurrentDate.month);
                    // getGraphBasedOnSales(currentDate: CurrentDate.month);
                  } else {
                    getTheCurrentDate(CurrentDate.year);
                    // getGraphBasedOnSales(currentDate: CurrentDate.year);
                  }
                },
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
            ),
          ),
          SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //Sold item
                ValueListenableBuilder(
                  valueListenable: numberOfItemSoldListNotifier,
                  builder: (context, value, child) => CustomContainer(
                    title: 'No. of Item sold',
                    subtitle: value.toString(),
                    haveBgColor: false,
                  ),
                ),

                //Total sale
                ValueListenableBuilder(
                  valueListenable: priceAmountOfItemSoldListNotifier,
                  builder: (context, value, child) => CustomContainer(
                    title: 'Total sale',
                    subtitle: formatMoney(number: value, haveEndSymbol: true),
                  ),
                ),
              ],
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 200,
              width: double.maxFinite,
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 15,
                  top: 15,
                ),
                child: ValueListenableBuilder(
                  valueListenable: graphPointListNotifier,
                  builder: (context, pointList, child) => LineChart(
                    LineChartData(
                        maxX: 7,
                        gridData: const FlGridData(
                          show: true,
                          drawVerticalLine: false,
                        ),
                        titlesData: FlTitlesData(
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                DateTime date = getTheCurrentDateStartOrEnd(
                                        currentDate: CurrentDate.week)
                                    .add(Duration(days: value.toInt() - 1));
                                return SideTitleWidget(
                                  axisSide: meta.axisSide,
                                  child: Text(
                                    '${date.day}/${date.month}',
                                    style: const TextStyle(fontSize: 10),
                                  ),
                                );
                              },
                            ),
                          ),
                          rightTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          topTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                        ),
                        borderData: FlBorderData(
                          show: true,
                          border:
                              Border.all(color: MyColors.lightGrey, width: 1),
                        ),
                        lineBarsData: [
                          LineChartBarData(
                            spots: pointList,
                            color: Colors.blue,
                            barWidth: 3,
                            isCurved: true,
                            dotData: const FlDotData(
                              show: true,
                            ),
                            belowBarData: BarAreaData(
                              show: true,
                              color: const Color.fromARGB(42, 40, 137, 217),
                            ),
                          )
                        ]),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //Brands
                  const Text(
                    'Resent',
                    style: MyFontStyle.listTileFont,
                  ),

                  //See all
                  //todo: Add the see all button functions
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => AllSaleDataScreen()));
                    },
                    child: const Text(
                      'See all',
                      style: TextStyle(color: MyColors.green),
                    ),
                  ),
                ],
              ),
            ),
          ),

          //todo: add recent sales here.
          FutureBuilder(
              future: _fetchSaleData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SliverToBoxAdapter(
                      child: Center(child: CircularProgressIndicator()));
                } else if (snapshot.hasError) {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: Text('Error: ${snapshot.error}'),
                    ),
                  );
                } else {
                  return (customerListNotifier.value.isEmpty)
                      ? SliverToBoxAdapter(
                          child: Container(
                            width: double.infinity,
                            height: MyScreenSize.screenHeight * .2,
                            alignment: AlignmentDirectional.center,
                            child: const Text('No sale is added'),
                          ),
                        )
                      : ValueListenableBuilder(
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
              }),
        ],
      ),
      // floatingActionButton: FloatingActionButtonForAll(
      //   text: 'Add new sale',
      //   onPressed: () {
      //     Navigator.of(context)
      //         .push(MaterialPageRoute(builder: (ctx) => const SaleAddNew()));
      //   },
      //   color: MyColors.red,
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

final List<String> list = ['This week', 'This month', 'This year', 'All Sales'];
