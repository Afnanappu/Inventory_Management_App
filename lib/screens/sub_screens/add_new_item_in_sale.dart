import 'package:flutter/material.dart';
import 'package:inventory_management_app/constants/colors.dart';
import 'package:inventory_management_app/database/brand_fun.dart';
import 'package:inventory_management_app/models/customer_model.dart';
import 'package:inventory_management_app/models/item_model.dart';
import 'package:inventory_management_app/screens/sub_screens/add_new_sale.dart';
import 'package:inventory_management_app/widgets/appbar/app_bar_for_sub_with_edit.dart';
import 'package:inventory_management_app/widgets/button_add_sale.dart';
import 'package:inventory_management_app/widgets/drop_down_for_all.dart';
import 'package:inventory_management_app/widgets/text_form_field.dart';

class AddNewItemInSale extends StatefulWidget {
  final ItemModel? itemModel;
  const AddNewItemInSale({super.key, this.itemModel});

  @override
  State<AddNewItemInSale> createState() => _AddNewItemInSaleState();
}

class _AddNewItemInSaleState extends State<AddNewItemInSale> {
  final _itemPriceController = TextEditingController();

  final _itemStockController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  int selectedItemQuantity = 0;

  ItemModel? item;

  @override
  void initState() {
    _itemStockController.text = '1';
    if (widget.itemModel != null) {
      item = widget.itemModel;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (item != null) {
      _itemPriceController.text = item!.itemPrice.toString();
    }
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.maxFinite, 60),
        child: AppBarForSubWithEdit(
          title: 'Add item to Sale',
          isAddIcon: false,
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              DropDownForAll(
                nowValue: item,
                formFillColor: MyColors.white,
                haveBorder: true,
                items: itemModelListNotifiers.value
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Text(e.itemName),
                      ),
                    )
                    .toList(),
                onChanged: (e) {
                  setState(() {
                    item = e;
                    for (var element in currentSaleItemNotifier.value) {
                      if (element.itemId == item!.id) {
                        selectedItemQuantity += element.itemCount;
                      }
                    }
                  });
                },
                hintText: 'Select item',
                validator: (value) {
                  if (value == null) {
                    return 'Select an item';
                  } else {
                    return null;
                  }
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: customFormField(
                      context: context,
                      labelText: 'Price',
                      controller: _itemPriceController,
                      formFillColor: MyColors.white,
                      haveBorder: true,
                      isFormEnabled: false,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: customFormField(
                      context: context,
                      labelText: 'Quantity',
                      controller: _itemStockController,
                      keyboardType: TextInputType.number,
                      formFillColor: MyColors.white,
                      haveBorder: true,
                      validator: (value) {
                        int quantity = 1;
                        int stock = item!.stock - selectedItemQuantity;
                        if (value == null ||
                            value.isEmpty ||
                            0 == int.parse(value)) {
                          return "add quantity";
                        } else if (value.isNotEmpty) {
                          quantity = int.parse(value);
                          if (item != null && quantity > stock) {
                            return 'out of stock${stock == 0 ? 'item' : ', try $stock'} ';
                          } else {
                            return null;
                          }
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
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
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      final itemCount = int.parse(_itemStockController.text);
                      final itemPrice = double.parse(_itemPriceController.text);
                      final sale =
                          SaleModel(itemId: item!.id!, itemCount: itemCount);
                      currentSaleItemNotifier.value.add(sale);
                      notifyAnyListeners(currentSaleItemNotifier);
                      final sum = itemCount.toDouble() * itemPrice;
                      totalAmountNotifier.value += sum;
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (ctx) => const AddNewItemInSale(),
                        ),
                      );
                    }
                  }),
            ),
            Expanded(
              child: buttonAddSale(
                  text: 'Save',

                  //todo: Add function to save data
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      final itemCount = int.parse(_itemStockController.text);
                      final itemPrice = double.parse(_itemPriceController.text);
                      final sale =
                          SaleModel(itemId: item!.id!, itemCount: itemCount);
                      currentSaleItemNotifier.value.add(sale);
                      notifyAnyListeners(currentSaleItemNotifier);
                      final sum = itemCount.toDouble() * itemPrice;
                      totalAmountNotifier.value += sum;
                      Navigator.of(context).pop();
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
