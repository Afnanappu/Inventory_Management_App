import 'package:flutter/material.dart';
import 'package:inventory_management_app/widgets/appbar/app_bar_for_sub_with_edit.dart';

class PurchseScreen extends StatelessWidget {
  const PurchseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.maxFinite, 60),
        child: AppBarForSubWithEdit(
          title: "Purchases",
          isAddIcon: false,
        ),
      ),
    );
  }
}