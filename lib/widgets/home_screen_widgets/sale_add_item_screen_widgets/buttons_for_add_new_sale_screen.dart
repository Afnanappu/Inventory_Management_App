// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:inventory_management_app/constants/colors.dart';
import 'package:inventory_management_app/database/brand_fun.dart';
import 'package:inventory_management_app/database/customer_fun.dart';
import 'package:inventory_management_app/database/sales_fun.dart';
import 'package:inventory_management_app/models/customer_model.dart';
import 'package:inventory_management_app/screens/sub_screens/add_new_sale.dart';
import 'package:inventory_management_app/widgets/common/alert_dialog.dart';
import 'package:inventory_management_app/widgets/common/snack_bar_messenger.dart';
import 'package:inventory_management_app/widgets/home_screen_widgets/button_add_sale.dart';
import 'package:inventory_management_app/widgets/home_screen_widgets/sale_add_item_screen_widgets/success_animation_screen.dart';

class ButtonsForAddNewSaleScreen extends StatelessWidget {
  const ButtonsForAddNewSaleScreen({
    super.key,
    required this.widget,
    required GlobalKey<FormState> formKey,
    required TextEditingController customerNameController,
    required TextEditingController customerPhoneController,
    required this.selectedDate,
    required this.mounted,
  })  : _formKey = formKey,
        _customerNameController = customerNameController,
        _customerPhoneController = customerPhoneController;

  final SaleAddNew widget;
  final GlobalKey<FormState> _formKey;
  final TextEditingController _customerNameController;
  final TextEditingController _customerPhoneController;
  final DateTime selectedDate;
  final bool mounted;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        height: 85,
        color: MyColors.white,
        child: (!widget.isViewer)
            ? Row(
                children: [
                  Expanded(
                    child: buttonAddSale(
                        text: 'Save&New',
                        haveBorder: true,
                        btnColor: MyColors.transparent,
                        //todo: Add function to save data
                        onTap: () async {
                          if (_formKey.currentState!.validate() &&
                              currentSaleItemNotifier.value.isNotEmpty) {
                            final sales = currentSaleItemNotifier.value;

                            final salesIdList = await addSalesToDB(sales);

                            final customer = CustomerModel(
                              customerName: _customerNameController.text,
                              customerPhone: _customerPhoneController.text,
                              saleId: salesIdList,
                              saleDateTime: selectedDate,
                            );

                            await addCustomerToDB(customer);

                            await decreaseListOfStockFromDB(salesIdList);

                            currentSaleItemNotifier.value.clear();
                            notifyAnyListeners(currentSaleItemNotifier);

                            if (mounted) {
                              CustomSnackBarMessage(
                                context: context,
                                message: 'Sale is added successfully',
                                color: MyColors.green,
                                duration: 2,
                              );
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (ctx) => const SaleAddNew()));
                            }
                          } else if (currentSaleItemNotifier.value.isEmpty) {
                            CustomSnackBarMessage(
                              context: context,
                              message: 'Add an item to save',
                              color: Colors.red,
                            );
                          }
                        }),
                  ),

                  //Save
                  Expanded(
                    child: buttonAddSale(
                      text: 'Save',
                      onTap: () async {
                        if (_formKey.currentState!.validate() &&
                            currentSaleItemNotifier.value.isNotEmpty) {
                          final sales = currentSaleItemNotifier.value;

                          final salesIdList = await addSalesToDB(sales);

                          final customer = CustomerModel(
                            customerName: _customerNameController.text,
                            customerPhone: _customerPhoneController.text,
                            saleId: salesIdList,
                            saleDateTime: selectedDate,
                          );

                          await addCustomerToDB(customer);

                          await decreaseListOfStockFromDB(salesIdList);

                          getTheNumberOfItemSold(
                              start: DateTime.now().subtract(
                                  Duration(days: DateTime.now().weekday - 1)));

                          getThePriceAmountOfItemSold(
                              start: DateTime.now().subtract(
                                  Duration(days: DateTime.now().weekday - 1)));


                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) =>
                                  const SuccessAnimationScreen()));
                        } else if (currentSaleItemNotifier.value.isEmpty) {
                          CustomSnackBarMessage(
                            context: context,
                            message:
                                'No item is selected, please select an item',
                            color: Colors.red,
                          );
                        }
                      },
                    ),
                  ),
                ],
              )
            : Row(
                children: [
                  Expanded(
                    child: buttonAddSale(
                      btnColor: MyColors.white,
                      haveBorder: true,
                      text: 'delete',
                      onTap: () {
                        log('Delete button is pressed');
                        customAlertBox(
                          context: context,
                          title: 'Delete sale',
                          content: 'Are you sure?',
                          onPressedYes: () async {
                            if (currentSaleItemNotifier.value.isEmpty) {
                              log('${widget.customer!.customerId}');
                              await deleteCustomerFromDB(
                                  widget.customer!.customerId!);
                            } else {
                              log("Can't delete customer because there is sales in in the customer sales");
                            }

                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: buttonAddSale(
                      text: 'Ok',
                      onTap: () async {
                        // Navigator.of(context).pushReplacement(
                        //   MaterialPageRoute(
                        //     builder: (context) => SaleAddNew(
                        //       customer: widget.customer,
                        //       isEditable: true,
                        //     ),
                        //   ),
                        // );
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              ));
  }
}
