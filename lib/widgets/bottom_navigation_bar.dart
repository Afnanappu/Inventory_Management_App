import 'package:flutter/material.dart';
import 'package:inventory_management_app/constants/colors.dart';

class MyBottomNavigationBar extends StatefulWidget {
  MyBottomNavigationBar(
      {super.key, required this.currentIndex, required this.pageController});
  int currentIndex;
  final PageController pageController;
  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (value) {
        setState(() {
          widget.currentIndex = value;
        });
        widget.pageController.jumpToPage(widget.currentIndex);
      },
      currentIndex: widget.currentIndex,
      backgroundColor: MyColors.white,
      selectedItemColor: MyColors.green,
      selectedIconTheme: const IconThemeData(
        color: MyColors.green,
      ),
      unselectedItemColor: MyColors.blackShade,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.shifting,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart), label: "Dashboard"),
        BottomNavigationBarItem(
            icon: Icon(Icons.check_box_outline_blank), label: "Item"),
        BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month), label: "Account")
      ],
    );
  }
}
