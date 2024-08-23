import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'customer_model.g.dart';

ValueNotifier<List<SaleModel>> saleItemsListNotifier = ValueNotifier([]);
ValueNotifier<List<CustomerModel>> customerListNotifier = ValueNotifier([]);

@HiveType(typeId: 3)
class CustomerModel {
  @HiveField(0)
  int? customerId;

  @HiveField(1)
  String customerName;

  @HiveField(2)
  String customerPhone;

  @HiveField(3)
  List<int> saleId;

  @HiveField(4)
  DateTime saleDateTime;

  CustomerModel({
    required this.customerName,
    required this.customerPhone,
    required this.saleDateTime,
    required this.saleId,
    this.customerId,
  });
}

@HiveType(typeId: 4)
class SaleModel {
  @HiveField(0)
  int? saleId;

  @HiveField(1)
  int itemId;

  @HiveField(2)
  int itemCount;

  SaleModel({
    required this.itemId,
    required this.itemCount,
    this.saleId,
  });
}
