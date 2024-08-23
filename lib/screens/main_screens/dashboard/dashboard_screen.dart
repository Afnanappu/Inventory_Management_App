import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management_app/constants/colors.dart';
import 'package:inventory_management_app/constants/font_styles.dart';
import 'package:inventory_management_app/screens/sub_screens/add_new_sale.dart';
import 'package:inventory_management_app/widgets/appbar/app_bar_for_main.dart';
import 'package:inventory_management_app/widgets/custom_container.dart';
import 'package:inventory_management_app/widgets/floating_action_button.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});

  final List<String> list = [
    'This week',
    'This month',
    'This year',
  ];

  @override
  Widget build(BuildContext context) {
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
                    onPressed: () {},
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
          // ValueListenableBuilder(
          //   valueListenable: itemBrandList,
          //   builder: (BuildContext context, List<ItemBrand> itemBrand, Widget? child) {
          //     return SliverList.builder(
          //     itemCount: 4,
          //     itemBuilder: (context, index) {

          //       return SaleListTile(
          //         image: itemBrand[index].itemModelList[],
          //         customerName: 'AFNAN',
          //         invoiceNo: '${index + 1}',
          //         brandName: itemModelList.value[index].itemBrandName,
          //         itemPrice: itemModelList.value[index].itemPrice,
          //       );
          //     },
          //   );
          //    },

          // )
        ],
      ),
      floatingActionButton: FloatingActionButtonForAll(
        text: 'Add new sale',
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (ctx) => SaleAddNew()));
        },
        color: MyColors.red,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
