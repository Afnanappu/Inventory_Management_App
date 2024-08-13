import 'package:flutter/material.dart';
import 'package:inventory_management_app/constants/colors.dart';
import 'package:inventory_management_app/screens/first_screens/login_screen.dart';
import 'package:inventory_management_app/screens/main_screens/account/busines%20profile/business_profile.dart';
import 'package:inventory_management_app/widgets/app_bar_for_main.dart';
import 'package:inventory_management_app/widgets/list_tile.dart';
import 'package:inventory_management_app/widgets/snack_bar_messenger.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(double.maxFinite, 60),
          child: AppBarForMain(
            title: "Account",
            icon: Icons.logout,
            onPressed: () {
              _alertBox(
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
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: Column(
          children: [
            myListTile(
                context: context,
                title: 'Business Profile',
                icon: Icons.business,onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> BusinessProfile()),);
                }),
            myListTile(
                context: context,
                title: 'Brands',
                icon: Icons.category_outlined),
            myListTile(
                context: context,
                title: 'Help & Support',
                icon: Icons.support_agent_outlined),
            myListTile(
                context: context,
                title: 'Rate this app',
                icon: Icons.star_rate_outlined),
            myListTile(
                context: context,
                title: 'Share this app',
                icon: Icons.share_outlined),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: MyColors.white,
          elevation: 0,
          child: const Column(
            children: [
              Text(
                'Version',
                style: TextStyle(color: Color.fromARGB(255, 223, 223, 223)),
              ),
              Text(
                '1.0.0',
                style: TextStyle(color: Color.fromARGB(255, 223, 223, 223)),
              ),
            ],
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _alertBox(
      {required BuildContext context,
      required String title,
      required String content,
      required void Function()? onPressedYes}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              TextButton(
                onPressed: onPressedYes,
                child: const Text('Yes'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('No'),
              ),
            ],
          );
        });
  }
}
