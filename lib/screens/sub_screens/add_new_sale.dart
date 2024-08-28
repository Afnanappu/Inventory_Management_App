import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:inventory_management_app/constants/colors.dart';
import 'package:inventory_management_app/database/brand_fun.dart';
import 'package:inventory_management_app/database/customer_fun.dart';
import 'package:inventory_management_app/database/item_fun.dart';
import 'package:inventory_management_app/database/sales_fun.dart';
import 'package:inventory_management_app/functions/format_money.dart';
import 'package:inventory_management_app/models/customer_model.dart';
import 'package:inventory_management_app/screens/sub_screens/add_new_item_in_sale.dart';
import 'package:inventory_management_app/widgets/appbar/app_bar_for_sub_with_edit.dart';
import 'package:inventory_management_app/widgets/button_add_sale.dart';
import 'package:inventory_management_app/widgets/sale_add_item.dart';
import 'package:inventory_management_app/widgets/snack_bar_messenger.dart';
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

  double totalAmount = 0;

  final _formKey = GlobalKey<FormState>();

  DateTime selectedDate = DateTime.now();

  @override
  void dispose() {
    currentSaleItemNotifier.value.clear();
    super.dispose();
  }

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
                keyboardType: TextInputType.phone,
                formFillColor: MyColors.white,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'phone no is empty';
                  } else if (value.length < 10) {
                    return 'Enter 10 digit number';
                  }
                   else if (value.length > 10) {
                    return 'Too many digits, try again';
                  }
                   else {
                    return null;
                  }
                },
              ),
              ValueListenableBuilder(
                  valueListenable: currentSaleItemNotifier,
                  builder: (context, saleItem, child) {
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: saleItem.length,
                        itemBuilder: (context, index) {
                          final item = getItemFromDB(saleItem[index].itemId);
                          final sale = saleItem[index];

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: ListTile(
                              tileColor:
                                  const Color.fromARGB(255, 243, 255, 227),
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      item.itemName,
                                      softWrap: true,
                                      overflow: TextOverflow.clip,
                                      style: const TextStyle(
                                          color: MyColors.blackShade,
                                          fontWeight: FontWeight.w600),
                                    ),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Subtotal'),
                                  Text(
                                      '${sale.itemCount} x ${formatMoney(number: item.itemPrice,haveSymbol: false)} = ${formatMoney(number: item.itemPrice * sale.itemCount)}'),
                                ],
                              ),
                            ),
                          );
                        });
                  }),
              saleAddItem(onTap: () async {
                final String sumString = await Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => const AddNewItemInSale()),
                );
                var sum = double.parse(sumString);

                setState(() {
                  totalAmount += sum;
                });
              }),
              const SizedBox(
                height: 15,
              ),
              //total Amount
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total Amount',
                    style: TextStyle(
                        color: MyColors.blackShade,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  Container(
                    constraints:
                        const BoxConstraints(maxWidth: 180, minWidth: 100),
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: MyColors.blackShade,
                                style: BorderStyle.solid))),
                    child: ListTile(
                      leading: const Text('₹',
                          style: TextStyle(
                              color: MyColors.blackShade,
                              fontSize: 18,
                              fontWeight: FontWeight.w600)),
                      title: Text(
                        formatMoney(number: totalAmount,haveSymbol: false),textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: MyColors.blackShade,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  )
                ],
              )
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
                  onTap: () async {
                    if (_formKey.currentState!.validate() &&
                        currentSaleItemNotifier.value.isNotEmpty) {
                      final sales = currentSaleItemNotifier.value;

                      final salesIdList = await addSalesToDB(sales);

                      final customer = CustomerModel(
                        customerName: _customerNameController.text,
                        customerPhone: _customerPhoneController.text,
                        saleId: salesIdList,
                        saleDateTime: DateTime.now(),
                      );

                      await addCustomerToDB(customer);

                      currentSaleItemNotifier.value.clear();
                      notifyAnyListeners(saleItemsListNotifier);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (ctx) => const SaleAddNew()));
                      CustomSnackBarMessage(
                        context: context,
                        message: 'Sale is added successfully',
                        color: MyColors.green,
                        duration: 2,
                      );
                    } else if (currentSaleItemNotifier.value.isEmpty) {
                      CustomSnackBarMessage(
                          context: context,
                          message: 'Add an item to save',
                          color: Colors.red);
                    }
                  }),
            ),
            Expanded(
              child: buttonAddSale(
                text: 'Save',

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
                      saleDateTime: DateTime.now(),
                    );

                    await addCustomerToDB(customer);

                    await decreaseListOfStockFromDB(salesIdList);

                    getTheNumberOfItemSold();

                    getThePriceAmountOfItemSold();

                    Navigator.of(context).pop();
                    CustomSnackBarMessage(
                      context: context,
                      message: 'Sale is added successfully',
                      color: MyColors.green,
                      duration: 2,
                    );
                  } else if (currentSaleItemNotifier.value.isEmpty) {
                    CustomSnackBarMessage(
                        context: context,
                        message: 'Add an item to save',
                        color: Colors.red);
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
