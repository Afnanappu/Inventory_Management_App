import 'package:flutter/material.dart';
import 'package:inventory_management_app/constants/colors.dart';
import 'package:inventory_management_app/constants/font_styles.dart';
import 'package:inventory_management_app/constants/screen_size.dart';
import 'package:inventory_management_app/database/customer_fun.dart';
import 'package:inventory_management_app/database/sales_fun.dart';
import 'package:inventory_management_app/functions/date_time_functions.dart';
import 'package:inventory_management_app/models/customer_model.dart';
import 'package:inventory_management_app/models/profile_model.dart';
import 'package:inventory_management_app/screens/main_screens/dashboard/all_sale_data.dart';
import 'package:inventory_management_app/screens/main_screens/home/home_screen.dart';
import 'package:inventory_management_app/widgets/appbar/app_bar_for_main.dart';
import 'package:inventory_management_app/widgets/customer_list_for_dashboard.dart';
import 'package:inventory_management_app/widgets/dropdown_for_dashboard.dart';
import 'package:inventory_management_app/widgets/graph_for_dashboard.dart';
import 'package:inventory_management_app/widgets/sale_and_price_container_for_dashboard.dart';

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
          DropDownForDashboard(selectedValue: _selectedValue),
          const SaleAndPriceContainerForDashboard(),
          const GraphForDashboard(),
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
                      : const CustomerListForDashboard();
                }
              }),
        ],
      ),
    );
  }
}


  // floatingActionButton: FloatingActionButtonForAll(
      //   text: 'Add new sale',
      //   onPressed: () {
      //     Navigator.of(context)
      //         .push(MaterialPageRoute(builder: (ctx) => const SaleAddNew()));
      //   },
      //   color: MyColors.red,
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,