import 'package:flutter/material.dart';
import 'package:inventory_management_app/widgets/app_bar_for_sub_with_edit.dart';

class BusinessProfile extends StatelessWidget {
  const BusinessProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize:const Size(double.maxFinite, 60), child: AppBarForSubWithEdit(title: 'Business Profile', onPressed: (){})),
      body: Column(),
    );
  }
}