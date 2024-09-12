import 'package:flutter/material.dart';
import 'package:inventory_management_app/constants/colors.dart';
import 'package:inventory_management_app/database/purchases_fun.dart';
import 'package:inventory_management_app/functions/format_money.dart';
import 'package:inventory_management_app/models/purchase_model.dart';
import 'package:inventory_management_app/screens/sub_screens/add_new_purchase.dart';
import 'package:inventory_management_app/widgets/appbar/app_bar_for_sub_with_edit.dart';
import 'package:inventory_management_app/widgets/common/floating_action_button.dart';
import 'package:inventory_management_app/widgets/dashboard_screen_widgets/sale_list_tile.dart';

class PurchaseScreen extends StatelessWidget {
  const PurchaseScreen({super.key});

  Future<void> _loadPurchaseData() async {
    await getAllPurchasesFromDB();
  }

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
      body: FutureBuilder(
        future: _loadPurchaseData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return purchasedItemListNotifier.value.isEmpty
                ? const Center(
                    child: Text('No purchase is added'),
                  )
                : ValueListenableBuilder(
                    valueListenable: purchasedItemListNotifier,
                    builder: (context, purchaseModel, child) {
                      return ListView.builder(
                        itemCount: purchaseModel.length,
                        itemBuilder: (BuildContext context, int index) {
                          final purchase = purchaseModel[index];
                          return CustomerListTile(
                            customerName: purchase.partyName,
                            invoiceNo: '${index + 1}',
                            totalProduct: purchase.itemsId.length,
                            itemPrice: formatMoney(number: 100000),
                            saleAddDate: purchase.dateTime,
                            onTap: () {},
                          );
                        },
                      );
                    },
                  );
          }
        },
      ),
      floatingActionButton: FloatingActionButtonForAll(
        text: 'Add Purchase',
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (ctx) => const AddNewPurchaseScreen()),
          );
        },
        color: MyColors.red,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
