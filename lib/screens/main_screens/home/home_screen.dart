import 'package:flutter/material.dart';
import 'package:inventory_management_app/constants/colors.dart';
import 'package:inventory_management_app/constants/font_styles.dart';
import 'package:inventory_management_app/constants/screen_size.dart';
import 'package:inventory_management_app/screens/sub_screens/add_new_sale.dart';
import 'package:inventory_management_app/widgets/appbar/app_bar_for_main.dart';
import 'package:inventory_management_app/screens/main_screens/home/brand_items.dart';
import 'package:inventory_management_app/widgets/floating_action_button.dart';
import 'package:inventory_management_app/screens/main_screens/home/item_details_for_home.dart';
import 'package:inventory_management_app/widgets/price_filter.dart';
import 'package:inventory_management_app/widgets/search_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MyScreenSize.initialize(context);

    return Scaffold(
      //App bar
      appBar: PreferredSize(
        preferredSize: const Size(double.maxFinite, 60),
        child: AppBarForMain(
            title: 'Shop Name',
            onPressed: () {
              Navigator.of(context).pushNamed("/NotificationScreen");
            }),
      ),

      //body
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: MyScreenSize.screenHeight18),
        child: CustomScrollView(
          slivers: [
            //space
            SliverToBoxAdapter(
              child: SizedBox(
                height: MyScreenSize.screenHeight10,
              ),
            ),

            //Search bar
            const SliverToBoxAdapter(child: SearchBarForMain()),

            //space
            SliverToBoxAdapter(
              child: SizedBox(
                height: MyScreenSize.screenHeight18,
              ),
            ),

            //brand and see all
            SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //Brands
                  const Text(
                    'Brands',
                    style: MyFontStyle.main,
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

            //space
            SliverToBoxAdapter(
              child: SizedBox(
                height: MyScreenSize.screenHeight5,
              ),
            ),

            //Brand items
            //todo: no scrolling and when see all button pressed the full list want to show.
            const SliverToBoxAdapter(child: BrandItems()),

            //space
            SliverToBoxAdapter(
              child: SizedBox(
                height: MyScreenSize.screenHeight10,
              ),
            ),

            //Price filter
            const SliverToBoxAdapter(child: PriceFilter()),

            //space
            SliverToBoxAdapter(
              child: SizedBox(
                height: MyScreenSize.screenHeight18,
              ),
            ),

            //Item Details
            const ItemDetailsForHome(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButtonForAll(
        text: 'Add new sale',
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (ctx) => const SaleAddNew()));
        },
        color: MyColors.red,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
