import 'package:flutter/material.dart';
import 'package:inventory_management_app/widgets/app_bar_for_main.dart';
import 'package:inventory_management_app/widgets/search_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.maxFinite, 60),
        child: AppBarForMain(title: "Shop Name"),
      ),
      body: Column(
        children: [
          SearchBarForMain()
        ]
      ),
    );
  }
}
