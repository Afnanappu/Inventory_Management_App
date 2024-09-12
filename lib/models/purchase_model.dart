import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'purchase_model.g.dart';

ValueNotifier<List<PurchaseModel>> purchasedItemListNotifier =
    ValueNotifier([]);

@HiveType(typeId: 6)
class PurchaseModel {
  @HiveField(0)
  int id;

  @HiveField(1)
  String partyName;

  @HiveField(2)
  String phone;

  @HiveField(3)
  List<int> itemsId;

  @HiveField(4)
  DateTime dateTime;

  PurchaseModel(
      {required this.id,
      required this.partyName,
      required this.phone,
      required this.dateTime,
      required this.itemsId});
}

class PurchaseItemModel {
  int? id;
  int itemId;
  int quantity;
  PurchaseItemModel({this.id, required this.itemId, required this.quantity});
}
