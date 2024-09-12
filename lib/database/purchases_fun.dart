import 'dart:developer';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:inventory_management_app/database/brand_fun.dart';
import 'package:inventory_management_app/models/purchase_model.dart';

// ignore: constant_identifier_names
const String PURCHASE_BOX = 'purchaseBox';

late Box<PurchaseModel> _purchaseBox;

Future<void> getAllPurchasesFromDB() async {
  _purchaseBox = await Hive.openBox<PurchaseModel>(PURCHASE_BOX);
  purchasedItemListNotifier.value = _purchaseBox.values.toList();

  notifyAnyListeners(purchasedItemListNotifier);
  log('fetching all the purchase from DB and the length is ${purchasedItemListNotifier.value.length}');
}

Future<void> addPurchaseToDB(PurchaseModel purchase) async {
  _purchaseBox = await Hive.openBox<PurchaseModel>(PURCHASE_BOX);

  await _purchaseBox.put(purchase.id, purchase);

  await getAllPurchasesFromDB();
}
