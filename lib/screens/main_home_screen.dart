import 'package:flutter/material.dart';
import 'package:inventory_management_app/screens/main_screens/account_screen.dart';
import 'package:inventory_management_app/screens/main_screens/dashboard_screen.dart';
import 'package:inventory_management_app/screens/main_screens/home_screen.dart';
import 'package:inventory_management_app/screens/main_screens/item_screen.dart';
import 'package:inventory_management_app/widgets/bottom_navigation_bar.dart';

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  int currentIndex = 0;
  final _pageViewController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          onPageChanged: (value) {
            setState(() {
              currentIndex = value;
            });
            _pageViewController.jumpToPage(currentIndex);
          },
          controller: _pageViewController,
          children: const [
            HomeScreen(),
            DashboardScreen(),
            ItemScreen(),
            AccountScreen()
          ],
        ),
        //todo: Change the icon
        bottomNavigationBar: MyBottomNavigationBar(
          currentIndex: currentIndex,
          pageController: _pageViewController,
        ),);
  }
}
