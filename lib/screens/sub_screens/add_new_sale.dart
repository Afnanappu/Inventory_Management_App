import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:inventory_management_app/constants/colors.dart';
import 'package:inventory_management_app/screens/sub_screens/add_new_item_in_sale.dart';
import 'package:inventory_management_app/widgets/appbar/app_bar_for_sub_with_edit.dart';
import 'package:inventory_management_app/widgets/button_add_sale.dart';
import 'package:inventory_management_app/widgets/sale_add_item.dart';
import 'package:inventory_management_app/widgets/text_form_field.dart';

// ignore: must_be_immutable
class SaleAddNew extends StatefulWidget {
  SaleAddNew({super.key});

  @override
  State<SaleAddNew> createState() => _SaleAddNewState();
}

class _SaleAddNewState extends State<SaleAddNew> {
  final _customerNameController = TextEditingController();

  final _phoneController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  // var dt;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.maxFinite, 60),
        child: AppBarForSubWithEdit(
          title: 'Add Sale',
          isAddIcon: false,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                      border:
                          Border(right: BorderSide(color: MyColors.lightGrey))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Invoice No.'),
                      Text('1'),
                    ],
                  ),
                )),
                Expanded(
                    child: SizedBox(
                  child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: InkWell(
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: selectedDate,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2050),
                          );

                          setState(() {
                            if (pickedDate != null) {
                              selectedDate = pickedDate;
                            }
                          });
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Date'),
                            Text(DateFormat('dd/MM//yy').format(selectedDate))
                          ],
                        ),
                      )),
                )),
              ],
            ),
            customFormField(
              context: context,
              labelText: 'Customer name',
              haveBorder: true,
              controller: _customerNameController,
              formFillColor: MyColors.white,
              isFormEnabled: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Customer name is empty';
                } else if (value.length < 3) {
                  return 'Enter a valid name';
                } else {
                  return null;
                }
              },
            ),
            customFormField(
              context: context,
              labelText: 'Phone no',
              haveBorder: true,
              controller: _phoneController,
              formFillColor: MyColors.white,
              isFormEnabled: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'phone no is empty';
                } else if (value.length == 10) {
                  return 'Enter a valid phone no';
                } else {
                  return null;
                }
              },
            ),
            saleAddItem(onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => AddNewItemInSale()));
            }),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: MyColors.white,
        child: Row(
          children: [
            Expanded(
              child: buttonAddSale(
                text: 'Save&New',
                haveBorder: true,
                btnColor: MyColors.transparent,
                //todo: Add function to save data
                onTap: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (ctx) => SaleAddNew())),
              ),
            ),
            Expanded(
              child: buttonAddSale(
                text: 'Save',

                //todo: Add function to save data
                onTap: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
