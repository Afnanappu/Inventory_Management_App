import 'package:flutter/material.dart';
import 'package:inventory_management_app/constants/screen_size.dart';
import 'package:inventory_management_app/screens/first_screens/login_screen.dart';
import 'package:inventory_management_app/screens/main_screens/account/brands/brands.dart';
import 'package:inventory_management_app/widgets/alert_dialog.dart';
import 'package:inventory_management_app/widgets/appbar/app_bar_for_main.dart';
import 'package:inventory_management_app/widgets/bottom_sheet.dart';
import 'package:inventory_management_app/widgets/list_tile.dart';
import 'package:inventory_management_app/widgets/snack_bar_messenger.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'business profile/business_profile.dart';

class AccountScreen extends StatelessWidget {
  AccountScreen({super.key});

  String _version = '';

  Future<void> _loadVersionData() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    _version = packageInfo.version;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size(double.maxFinite, 60),
          child: AppBarForMain(
            title: "Account",
            icon: Icons.logout,
            onPressed: () {
              customAlertBox(
                  context: context,
                  title: 'LogOut',
                  content: 'Are you sure?',
                  onPressedYes: () {
                    CustomSnackBarMessage(
                        context: context,
                        message: 'Log out completed successfully',
                        color: Colors.blue);
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (ctx) => LoginScreen()),
                      (route) => false,
                    );
                  });
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            child: SizedBox(
              height: MyScreenSize.screenHeight*0.75,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      myListTile(
                          context: context,
                          title: 'Business Profile',
                          icon: Icons.business,
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (ctx) => const AccountProfile()),
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
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        'Version',
                        style:
                            TextStyle(color: Color.fromARGB(255, 223, 223, 223)),
                      ),
                      FutureBuilder(
                        future: _loadVersionData(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                                  ConnectionState.waiting 
                              ) {
                            return const Text(
                              '1.0.0',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 223, 223, 223)),
                            );
                          } 
                          else if(snapshot.hasError){
                            return Text(
                              // 'Error: ${snapshot.error}',
                              '1.0.0',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 223, 223, 223)),
                            );
                          }
                  
                          else {
                            return Text(
                              _version,
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 223, 223, 223)),
                            );
                          }
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
