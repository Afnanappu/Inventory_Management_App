import 'package:flutter/material.dart';
import 'package:inventory_management_app/screens/sub_screens/brands_screen.dart';
import 'package:inventory_management_app/screens/sub_screens/business_profile_screen.dart';
import 'package:inventory_management_app/screens/sub_screens/purchase_screen.dart';
import 'package:inventory_management_app/widgets/common/alert_dialog.dart';
import 'package:inventory_management_app/widgets/account_screen_widgets/bottom_sheet_for_help_and_support.dart';
import 'package:inventory_management_app/widgets/account_screen_widgets/list_tile.dart';

class AllListTileForAccountScreen extends StatelessWidget {
  const AllListTileForAccountScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        myListTile(
            context: context,
            title: 'Business Profile',
            icon: Icons.business,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => const AccountProfile()),
              );
            }),
        myListTile(
          context: context,
          title: 'Brands',
          icon: Icons.category_outlined,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (ctx) => AccountBrands()),
            );
          },
        ),
        myListTile(
          context: context,
          title: 'Purchases',
          icon: Icons.shopping_cart_outlined,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (ctx) => const PurchaseScreen()),
            );
          },
        ),
        myListTile(
          context: context,
          title: 'Help & Support',
          icon: Icons.support_agent_outlined,
          onTap: () {
            CustomHelpBottomSheet(context: context);
          },
        ),
        myListTile(
          context: context,
          title: 'Rate this app',
          icon: Icons.star_rate_outlined,
          onTap: () {
            customAlertBox(
              context: context,
              title: 'Rate this app',
              content: 'Open website to rate this app?',
              onPressedYes: () {},
            );
          },
        ),
        myListTile(
          context: context,
          title: 'Share this app',
          icon: Icons.share_outlined,
        ),
      ],
    );
  }
}
