import 'package:flutter/material.dart';
import 'package:inventory_management_app/widgets/appbar/app_bar_for_sub_with_edit.dart';

class BrandAddNew extends StatelessWidget {
  const BrandAddNew({super.key});

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.maxFinite, 60),
        child: AppBarForSubWithEdit(
          title: "Edit Brand",
          isAddIcon: false,
        ),
      ),
      body: Column(
        
      ),
    );
  }
}