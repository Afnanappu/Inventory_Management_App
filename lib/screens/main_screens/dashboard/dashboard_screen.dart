import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management_app/constants/colors.dart';
import 'package:inventory_management_app/constants/font_styles.dart';
import 'package:inventory_management_app/constants/screen_size.dart';
import 'package:inventory_management_app/database/brand_fun.dart';
import 'package:inventory_management_app/database/customer_fun.dart';
import 'package:inventory_management_app/database/item_fun.dart';
import 'package:inventory_management_app/database/sales_fun.dart';
import 'package:inventory_management_app/models/customer_model.dart';
import 'package:inventory_management_app/screens/main_screens/dashboard/all_sale_data.dart';
import 'package:inventory_management_app/screens/sub_screens/add_new_sale.dart';
import 'package:inventory_management_app/widgets/appbar/app_bar_for_main.dart';
import 'package:inventory_management_app/widgets/custom_container.dart';
import 'package:inventory_management_app/widgets/floating_action_button.dart';
import 'package:inventory_management_app/widgets/sale_list_tile.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final List<String> list = [
    'This week',
    'This month',
    'This year',
  ];

  @override
  void initState() {
    _loadDB().then(
      (value) => setState(() {
        print('customers and sales in loaded after waiting');
      }),
    );
    super.initState();
  }

  Future<void> _loadDB() async {
    await getAllCustomersFormDB();
    await getAllSalesFromDB();
  }

  @override
  Widget build(BuildContext context) {
    _loadDB();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.maxFinite, 60),
        child: AppBarForMain(
            title: 'Shop Name',
            onPressed: () {
              Navigator.of(context).pushNamed("/NotificationScreen");
            }),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              child: DropdownButtonFormField(
                dropdownColor: MyColors.white,
                padding: const EdgeInsets.only(left: 20),
                value: list[0],
                decoration: const InputDecoration(border: InputBorder.none),
                items: list.map(
                  (e) {
                    return DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    );
                  },
                ).toList(),
                onChanged: (value) {},
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
            ),
          ),
          const SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomContainer(
                  title: 'No. of Item sold',
                  subtitle: '10',
                  haveBgColor: false,
                ),
                CustomContainer(
                  title: 'Total sale',
                  subtitle: '₹125,500',
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
                child: LineChart(
                  LineChartData(
                      gridData: const FlGridData(
                        show: true,
                        drawVerticalLine: false,
                      ),
                      titlesData: const FlTitlesData(
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                      ),
                      borderData: FlBorderData(
                        show: true,
                        border: Border.all(color: MyColors.lightGrey, width: 1),
                      ),
                      betweenBarsData: [],
                      lineBarsData: [
                        LineChartBarData(
                          spots: const [
                            FlSpot(0, 0),
                            FlSpot(1, 1),
                            FlSpot(2, 0.5),
                            FlSpot(3, 0.5),
                            FlSpot(4, 1),
                            FlSpot(5, 1),
                            FlSpot(6, 2),
                          ],
                          color: Colors.blue,
                          barWidth: 3,
                          dotData: const FlDotData(show: true),
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
                          builder: (ctx) => const AllSaleDataScreen()));
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
          (customerListNotifier.value.isEmpty)
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
                  builder:
                      (BuildContext context, List<CustomerModel> customers, _) {
                    return SliverList.builder(
                      itemCount: (customers.length < 4) ? customers.length : 4,
                      itemBuilder: (context, index) {
                        final customerRev = customers.reversed.toList();
                        final customer = customerRev[index];
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
                          itemPrice: sumOfSales.toString(),
                          saleAddDate: customer.saleDateTime,
                        );
                      },
                    );
                  },
                )
        ],
      ),
      floatingActionButton: FloatingActionButtonForAll(
        text: 'Add new sale',
        onPressed: () {
          saleItemsListNotifier.value.clear();

          Navigator.of(context)
              .push(MaterialPageRoute(builder: (ctx) => const SaleAddNew()));
        },
        color: MyColors.red,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
