import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management_app/constants/colors.dart';
import 'package:inventory_management_app/constants/font_styles.dart';
import 'package:inventory_management_app/models/item_model.dart';
import 'package:inventory_management_app/widgets/appbar/app_bar_for_main.dart';
import 'package:inventory_management_app/widgets/sale_list_tile.dart';

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
            child:  SizedBox(
              height: 20,
            ),
          ),
          const SliverToBoxAdapter(
            child:  Row(
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
            child:SizedBox(height: 20,),
          ),

          SliverToBoxAdapter(
            child: SizedBox(
              height: 200,
              width: double.maxFinite,
              child: LineChart(
                LineChartData(
                    gridData: const FlGridData(
                      show: true,
                      drawVerticalLine: false,
                    ),
                    titlesData: const FlTitlesData(show: true),
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
          SliverList.builder(
            itemCount: 3,
            itemBuilder: (context, index) {
              return SaleListTile(
                image: itemModelList.value[index].itemImage,
                customerName: 'AFNAN',
                invoiceNo: '${index+1}',
                brandName: itemModelList.value[index].itemBrandName,
                itemPrice: itemModelList.value[index].itemPrice,
              ); 
            },
          )
        ],
      ),
    );
  }
}

class CustomContainer extends StatelessWidget {
  final bool haveBgColor;
  final String title;
  final String subtitle;

  const CustomContainer(
      {super.key,
      required this.title,
      required this.subtitle,
      this.haveBgColor = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 115,
      width: 145,
      decoration: BoxDecoration(
          color: (haveBgColor == true) ? MyColors.green : null,
          borderRadius: BorderRadius.circular(17),
          border: Border.all(color: MyColors.green, width: 1.5)),
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
                color: (haveBgColor == true) ? MyColors.white : MyColors.green,
                fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            subtitle,
            style: TextStyle(
                color: (haveBgColor == true) ? MyColors.white : MyColors.green,
                fontSize: 24,
                fontWeight: FontWeight.w700),
          )
        ],
      )),
    );
  }
}
