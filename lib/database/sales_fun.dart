import 'package:hive_flutter/hive_flutter.dart';
import 'package:inventory_management_app/models/customer_model.dart';

// ignore: constant_identifier_names
const SALES_BOX = 'SalesBox';

//Opened a box for item so we can use it any time
late Box<SaleModel> salesBox;

Future<void> getAllSalesFromDB() async {
  salesBox = await Hive.openBox<SaleModel>(SALES_BOX);
  saleItemsListNotifier.value.clear();
  saleItemsListNotifier.value = salesBox.values.toList();
  notifySaleItems();
  print('The number of sales in the DB is ${salesBox.values.length}');
}

Future<void> addSalesToDB(List<SaleModel> sales) async {
  salesBox = await Hive.openBox<SaleModel>(SALES_BOX);
  for (var i = 0; i < sales.length; i++) {
    sales[i].saleId = await salesBox.add(sales[i]);
    salesBox.put(sales[i].saleId, sales[i]);
    print('The sale at id = ${sales[i].saleId} is added to database');
  }
  getAllSalesFromDB();
  print('${sales.length} sales is added to database');
}

SaleModel getSaleFromFromDB(int saleId) {
  final sale = saleItemsListNotifier.value.firstWhere((sale) {
    return sale.saleId == saleId;
  });
  print('getSaleFromFromDB is worked. $saleId is and get ${sale.saleId}');
  return sale;
}

void notifySaleItems() {
  saleItemsListNotifier.notifyListeners();
}
