import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'customer_model.g.dart';

ValueNotifier<List<SaleModel>> currentSaleItemNotifier = ValueNotifier([]);
ValueNotifier<List<SaleModel>> saleItemsListNotifier = ValueNotifier([]);
ValueNotifier<List<ReturnSaleModel>> returnItemsListNotifier =
    ValueNotifier([]);
ValueNotifier<List<CustomerModel>> customerListNotifier = ValueNotifier([]);
ValueNotifier<List<CustomerModel>> dateTimeFilterNotifier = ValueNotifier([]);

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

  // @HiveField(3)
  // bool isReturned = false;

  SaleModel({
    required this.itemId,
    required this.itemCount,
    this.saleId,
    // this.isReturned = false,
  });
}

@HiveType(typeId: 5)
class ReturnSaleModel {
  @HiveField(0)
  int? id;

  @HiveField(1)
  int customerId;

  @HiveField(2)
  int saleId;

  @HiveField(3)
  DateTime dateTime;

  ReturnSaleModel({
    this.id,
    required this.customerId,
    required this.saleId,
    required this.dateTime,
  });
}
