import 'dart:core';

import 'package:flutter/material.dart';
import 'package:inventory_management_app/constants/colors.dart';
import 'package:inventory_management_app/database/brand_fun.dart';
import 'package:inventory_management_app/database/item_fun.dart';
import 'package:inventory_management_app/functions/date_time_functions.dart';
import 'package:inventory_management_app/functions/format_money.dart';
import 'package:inventory_management_app/functions/reg_exp_functions.dart';
import 'package:inventory_management_app/models/item_model.dart';
import 'package:inventory_management_app/models/purchase_model.dart';
import 'package:inventory_management_app/screens/sub_screens/add_new_item_in_sale.dart';
import 'package:inventory_management_app/screens/sub_screens/add_new_sale.dart';
import 'package:inventory_management_app/widgets/account_screen_widgets/purchase_list_tile.dart';
import 'package:inventory_management_app/widgets/appbar/app_bar_for_sub_with_edit.dart';
import 'package:inventory_management_app/widgets/common/text_form_field.dart';
import 'package:inventory_management_app/widgets/dashboard_screen_widgets/all_sale_screen_widgets/return_list_tile.dart';
import 'package:inventory_management_app/widgets/home_screen_widgets/sale_add_item.dart';
import 'package:inventory_management_app/widgets/home_screen_widgets/sale_add_item_screen_widgets/total_amount_section_for_sale_add_item_screen.dart';

class AddNewPurchaseScreen extends StatefulWidget {
  const AddNewPurchaseScreen({super.key});

  @override
  State<AddNewPurchaseScreen> createState() => _AddNewPurchaseScreenState();
}

final ValueNotifier<List<PurchaseItemModel>> currentPurchaseListNotifier =
    ValueNotifier([]);

class _AddNewPurchaseScreenState extends State<AddNewPurchaseScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _purchaserNameController =
      TextEditingController();
  final TextEditingController _purchaserPhoneController =
      TextEditingController();

  DateTime selectedDate = DateTime.now();

  @override
  void dispose() {
    totalAmountNotifier.value = 0;
    currentPurchaseListNotifier.value.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.maxFinite, 60),
        child: AppBarForSubWithEdit(
          title: 'Add Purchase',
          isAddIcon: false,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                          border: Border(
                              right: BorderSide(color: MyColors.lightGrey))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Invoice No.'),
                          Text('${purchasedItemListNotifier.value.length + 1}'),
                        ],
                      ),
                    ),
                  ),

                  //DatePick
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: SizedBox(
                        child: InkWell(
                          onTap: () async {
                            DateTime? pickedDate =
                                await pickDateFromUser(context: context);

                            setState(
                              () {
                                if (pickedDate != null) {
                                  selectedDate = pickedDate;
                                }
                              },
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Date'),
                              Row(
                                children: [
                                  Text(formatDateTime(date: selectedDate)),
                                  const Icon(Icons.arrow_drop_down)
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              customFormField(
                context: context,
                labelText: 'Party name',
                haveBorder: true,
                controller: _purchaserNameController,
                formFillColor: MyColors.white,
                validator: (value) {
                  if (value == null || CustomRegExp.checkEmptySpaces(value)) {
                    return 'Customer name is empty';
                  } else if (!CustomRegExp.checkName(value)) {
                    return 'Enter a valid name (use letter and space only)';
                  } else {
                    return null;
                  }
                },
              ),
              customFormField(
                context: context,
                labelText: 'Phone no',
                haveBorder: true,
                controller: _purchaserPhoneController,
                keyboardType: TextInputType.phone,
                formFillColor: MyColors.white,
                validator: (value) {
                  if (value == null || CustomRegExp.checkEmptySpaces(value)) {
                    return 'phone no is empty';
                  } else if (!CustomRegExp.checkPhoneNumber(value)) {
                    return 'Enter a valid phone number';
                  } else if (value.length < 10) {
                    return 'Enter 10 digit number';
                  } else if (value.length > 10) {
                    return 'Too many digits, try again';
                  } else {
                    return null;
                  }
                },
              ),

              //purchase added list

              const CurretenPurchaseListForPurchaseAddScreen(),

              //add new item to sale

              saleAddItem(onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (ctx) => const AddNewItemInSale(
                            isPurchase: true,
                          )),
                );
              }),

              const SizedBox(
                height: 15,
              ),

              //total Amount
              const TotalAmountSectionForSaleAddItemScreen()
            ],
          ),
        ),
      ),
    );
  }
}
