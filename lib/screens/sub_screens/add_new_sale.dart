import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:inventory_management_app/constants/colors.dart';
import 'package:inventory_management_app/database/customer_fun.dart';
import 'package:inventory_management_app/database/item_fun.dart';
import 'package:inventory_management_app/database/sales_fun.dart';
import 'package:inventory_management_app/models/customer_model.dart';
import 'package:inventory_management_app/screens/sub_screens/add_new_item_in_sale.dart';
import 'package:inventory_management_app/widgets/appbar/app_bar_for_sub_with_edit.dart';
import 'package:inventory_management_app/widgets/button_add_sale.dart';
import 'package:inventory_management_app/widgets/sale_add_item.dart';
import 'package:inventory_management_app/widgets/text_form_field.dart';

// ignore: must_be_immutable
class SaleAddNew extends StatefulWidget {
  const SaleAddNew({super.key});

  @override
  State<SaleAddNew> createState() => _SaleAddNewState();
}

class _SaleAddNewState extends State<SaleAddNew> {
  final _customerNameController = TextEditingController();

  final _customerPhoneController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  DateTime selectedDate = DateTime.now();

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
                    child: const Column(
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
                              const Text('Date'),
                              Row(
                                children: [
                                  Text(DateFormat('dd/MM//yy')
                                      .format(selectedDate)),
                                  const Icon(Icons.arrow_drop_down)
                                ],
                              ),
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
                controller: _customerPhoneController,
                formFillColor: MyColors.white,
                isFormEnabled: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'phone no is empty';
                  } else if (value.length != 10) {
                    return 'Enter a valid phone no';
                  } else {
                    return null;
                  }
                },
              ),
              ValueListenableBuilder(
                valueListenable: saleItemsListNotifier,
                builder: (context, saleItem, child) => ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: saleItem.length,
                    itemBuilder: (context, index) {
                      final item = getItemFromDB(saleItem[index].itemId);
                      final sale = saleItem[index];

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: ListTile(
                          tileColor: MyColors.lightGrey,
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                item.itemName,
                                style: const TextStyle(
                                    color: MyColors.blackShade,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                '${item.itemPrice * sale.itemCount}',
                                style: const TextStyle(
                                    color: MyColors.blackShade,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Subtotal'),
                              Text(
                                  '${sale.itemCount} x ${item.itemPrice} = ${item.itemPrice * sale.itemCount}'),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
              saleAddItem(onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => const AddNewItemInSale()));
              }),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 85,
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
                    MaterialPageRoute(builder: (ctx) => const SaleAddNew())),
              ),
            ),
            Expanded(
              child: buttonAddSale(
                text: 'Save',

                //todo: Add function to save data
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    final sales = saleItemsListNotifier.value;

                    await addSalesToDB(sales);

                    final customer = CustomerModel(
                      customerName: _customerNameController.text,
                      customerPhone: _customerPhoneController.text,
                      saleId: saleItemsListNotifier.value
                          .map(
                            (e) => e.saleId!,
                          )
                          .toList(),
                      saleDateTime: DateTime.now(),
                    );

                    await addCustomerToDB(customer);

                    Navigator.of(context).pop();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
