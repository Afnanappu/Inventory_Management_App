import 'package:hive_flutter/hive_flutter.dart';
import 'package:inventory_management_app/database/item_fun.dart';
import 'package:inventory_management_app/functions/generate_unique_id.dart';
import 'package:inventory_management_app/models/customer_model.dart';

// ignore: constant_identifier_names
const SALES_BOX = 'SalesBox';

//Opened a box for item so we can use it any time
late Box<SaleModel> salesBox;

Future<void> getAllSalesFromDB() async {
  salesBox = await Hive.openBox<SaleModel>(SALES_BOX);
  saleItemsListNotifier.value.clear();
  saleItemsListNotifier.value = salesBox.values.toList();
  saleItemsListNotifier.notifyListeners();

  // salesBox.clear();
  notifySaleItems();
  print('The number of sales in the DB is ${salesBox.values.length}');
}

Future<List<int>> addSalesToDB(List<SaleModel> sales) async {
  salesBox = await Hive.openBox<SaleModel>(SALES_BOX);
  List<int> salesIdList = [];
  for (var i = 0; i < sales.length; i++) {
    int id = generateUniqueId();
    sales[i].saleId = id;
    await salesBox.put(id, sales[i]);
    salesIdList.add(id);
    print('The sale at id = $id is added to database');
  }
  saleItemsListNotifier.notifyListeners();
  getAllSalesFromDB();
  print('${sales.length} sales is added to database');

  return salesIdList;
}

SaleModel getSaleFromFromDB(int saleId) {
  final sale = saleItemsListNotifier.value.firstWhere((sale) {
    return sale.saleId == saleId;
  });
  print('getSaleFromFromDB is worked. $saleId is and get ${sale.saleId}');
  return sale;
}

double getSumOfAllSaleOfOneCustomer(List<int> salesId) {
  double sum = 0;
  for (var id in salesId) {
    final sale = getSaleFromFromDB(id);
    final item = getItemFromDB(sale.itemId);
    sum += (item.itemPrice * sale.itemCount);
  }
  return sum;
}

Future<void> decreaseListOfStockFromDB(List<int> salesId) async {
  salesBox = await Hive.openBox<SaleModel>(SALES_BOX);

  for (var id in salesId) {
    final sale = getSaleFromFromDB(id);
    await decreaseOneItemStockFromDB(sale.itemId, sale.itemCount);
  }
  getAllItemFormDB();
  getAllSalesFromDB();

  // salesBox.values.firstWhere((sale)=> sale.saleId == saleId);
  // for (var id in salesId) {
  //   final sale = getSaleFromFromDB(id);
  //   final item = getItemFromDB(sale.itemId);
  //   final newItem = SaleModel(itemId: item.id!, itemCount: item.stock--);
  //   salesBox.put(item.id, newItem);
  //   print('The item stock at id = ${item.id} is changed');
  //   getAllSalesFromDB();
  // }
  print('Updating finished');
}

void notifySaleItems() {
  saleItemsListNotifier.notifyListeners();
}
