import 'package:flutter/material.dart';
import 'package:inventory_management_app/widgets/app_bar_for_main.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PreferredSize(preferredSize: Size(double.infinity, 150), child: AppBarForMain(title: "Shop Name"),),
      body: Center(
        child: Text("Home Screen"),
      ),
    );
  }
}
