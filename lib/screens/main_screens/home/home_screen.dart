import 'package:flutter/material.dart';
import 'package:inventory_management_app/constants/colors.dart';
import 'package:inventory_management_app/constants/screen_size.dart';
import 'package:inventory_management_app/database/brand_fun.dart';
import 'package:inventory_management_app/models/profile_model.dart';
import 'package:inventory_management_app/screens/sub_screens/add_new_sale.dart';
import 'package:inventory_management_app/widgets/appbar/app_bar_for_main.dart';
import 'package:inventory_management_app/screens/main_screens/home/brand_items.dart';
import 'package:inventory_management_app/widgets/floating_action_button.dart';
import 'package:inventory_management_app/screens/main_screens/home/item_details_for_home.dart';
import 'package:inventory_management_app/widgets/price_filter.dart';
import 'package:inventory_management_app/widgets/search_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static String profileName = 'Shop Name';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ProfileModel? profile;

  @override
  void initState() {
    _loadDB().then(
      (value) => setState(() {
        print('item is loaded after waiting');
      }),
    );

    super.initState();
  }

  Future<void> _loadDB() async {
    await getAllItemBrandFromDB();
    profile = await getProfile();
    if (profile != null) {
      HomeScreen.profileName = profile!.name!;
    }
  }

  @override
  Widget build(BuildContext context) {
    MyScreenSize.initialize(context);

    return Scaffold(
      //App bar
      appBar: PreferredSize(
        preferredSize: const Size(double.maxFinite, 60),
        child: AppBarForMain(
            title: HomeScreen.profileName,
            onPressed: () {
              Navigator.of(context).pushNamed("/NotificationScreen");
            }),
      ),

      //body
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: MyScreenSize.screenHeight18),
        child: const CustomScrollView(
          slivers: [
            //Search bar
             SliverToBoxAdapter(child: SearchBarForMain()),
            //Brand items
             SliverToBoxAdapter(child: BrandItems()),

            //Price filter
            SliverToBoxAdapter(child: PriceFilter()),

            //Item Details
            ItemDetailsForHome(),
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
