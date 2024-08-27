import 'package:hive_flutter/hive_flutter.dart';
import 'package:inventory_management_app/database/brand_fun.dart';
import 'package:inventory_management_app/database/item_fun.dart';
import 'package:inventory_management_app/functions/generate_unique_id.dart';
import 'package:inventory_management_app/models/customer_model.dart';
import 'package:inventory_management_app/models/item_model.dart';

// ignore: constant_identifier_names
const SALES_BOX = 'SalesBox';

//Opened a box for item so we can use it any time
late Box<SaleModel> salesBox;

Future<void> getAllSalesFromDB() async {
  salesBox = await Hive.openBox<SaleModel>(SALES_BOX);
  saleItemsListNotifier.value.clear();
  saleItemsListNotifier.value = salesBox.values.toList();

  // salesBox.clear();
  notifyAnyListeners(saleItemsListNotifier);
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
  getAllSalesFromDB();
  print('${sales.length} sales is added to database');

  return salesIdList;
}

SaleModel getSaleFromFromDB(int saleId) {
  final sale = saleItemsListNotifier.value.firstWhere((sale) {
    return sale.saleId == saleId;
  });
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
  print('Updating finished');
}

void getTheNumberOfItemSold() {
  numberOfItemSoldListNotifier.value = 0;
  if (saleItemsListNotifier.value.isNotEmpty) {
    for (var element in saleItemsListNotifier.value) {
      numberOfItemSoldListNotifier.value += element.itemCount;
    }
  }
  notifyAnyListeners(numberOfItemSoldListNotifier);
}

void getThePriceAmountOfItemSold() {
  List<int> salesId = [];
  if (saleItemsListNotifier.value.isNotEmpty) {
    for (var sale in saleItemsListNotifier.value) {
      salesId.add(sale.saleId!);
    }
    priceAmountOfItemSoldListNotifier.value =
        getSumOfAllSaleOfOneCustomer(salesId);
  }
  notifyAnyListeners(priceAmountOfItemSoldListNotifier);
}
