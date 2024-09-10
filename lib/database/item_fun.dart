// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:inventory_management_app/constants/colors.dart';
import 'package:inventory_management_app/database/brand_fun.dart';
import 'package:inventory_management_app/functions/generate_unique_id.dart';
import 'package:inventory_management_app/models/customer_model.dart';
import 'package:inventory_management_app/models/item_model.dart';
import 'package:inventory_management_app/widgets/common/snack_bar_messenger.dart';

// ignore: constant_identifier_names
const ITEM_BOX = 'ItemBox';

//Opened a box for item so we can use it any time
late Box<ItemModel> itemBox;

//Function to get all item from database and added to itemModelListNotifiers.
Future<void> getAllItemFormDB() async {
  itemBox = await Hive.openBox<ItemModel>(ITEM_BOX);
  itemModelListNotifiers.value = itemBox.values.cast<ItemModel>().toList();
  // itemBox.clear();
  notifyAnyListeners(itemModelListNotifiers);

  // print(
  //     'fetching all items from database\nThe number of item in the DB is ${itemBox.values.length}');
}

//Function to add item to database
Future<void> addItemToDB(ItemModel item) async {
  itemBox = await Hive.openBox<ItemModel>(ITEM_BOX);

  item.id = generateUniqueId();
  await itemBox.put(item.id, item);

  await getAllItemFormDB();
  notifyAnyListeners(itemFilterListNotifiers);
  // print(
  //     'A new item is added to database and the item id = ${item.id} and the brand id is = ${item.brandId} and the length of all item is ${itemBox.values.length}');
}

//Function to delete from database.
Future<void> deleteItemFromDB(int itemId, BuildContext context) async {
  itemBox = await Hive.openBox<ItemModel>(ITEM_BOX);

  final isNotDeletable = saleItemsListNotifier.value.any(
    (element) => element.itemId == itemId,
  );
  if (isNotDeletable == false) {
    await itemBox.delete(itemId);

    getAllItemFormDB();

    CustomSnackBarMessage(
      context: context,
      message: 'Item deleted successfully',
      color: MyColors.green,
    );
    print(
        'The item in the index $itemId is deleted and the length of all item is ${itemBox.values.length}');
  } else {
    CustomSnackBarMessage(
      context: context,
      message: 'The item is already used in the sales, can not delete item',
      color: MyColors.blackShade,
    );
    log(
      'Can not delete item from the db, because the item is already used in sales.',
    );
  }

  // await deleteSaleFromCustomerByItemId(itemId);
}

//Function to delete from database.
Future<void> editItemFromDB(int itemId, ItemModel item) async {
  itemBox = await Hive.openBox<ItemModel>(ITEM_BOX);
  await itemBox.put(itemId, item);

  await getAllItemFormDB();
  notifyAnyListeners(itemFilterListNotifiers);

  // print('The item in the index $itemId is edited');
}

ItemModel getItemFromDB(int itemId) {
  final item = itemModelListNotifiers.value.firstWhere(
    (item) => item.id == itemId,
  );
  return item;
}

Future<void> decreaseOneItemStockFromDB(int itemId, int quantity) async {
  itemBox = await Hive.openBox<ItemModel>(ITEM_BOX);
  final item = itemBox.values.firstWhere((item) => item.id == itemId);
  final newStock = item.stock - quantity;
  final newItem = ItemModel(
    id: item.id,
    brandId: item.brandId,
    itemName: item.itemName,
    itemImage: item.itemImage,
    itemPrice: item.itemPrice,
    color: item.color,
    ram: item.ram,
    rom: item.rom,
    description: item.description,
    stock: newStock,
  );
  await itemBox.put(item.id, newItem);

  notifyAnyListeners(itemFilterListNotifiers);
  // print('The stock count of item ${item.itemName} and count ${item.stock} is decreased by $quantity and now have $newStock');
}

Future<void> increaseOneItemStockFromDB(int itemId, int quantity) async {
  itemBox = await Hive.openBox<ItemModel>(ITEM_BOX);
  final item = itemBox.values.firstWhere((item) => item.id == itemId);
  final newStock = item.stock + quantity;
  final newItem = ItemModel(
    id: item.id,
    brandId: item.brandId,
    itemName: item.itemName,
    itemImage: item.itemImage,
    itemPrice: item.itemPrice,
    color: item.color,
    ram: item.ram,
    rom: item.rom,
    description: item.description,
    stock: newStock,
  );
  await itemBox.put(item.id, newItem);
  log('one item stock increased');
  getAllItemFormDB();
  notifyAnyListeners(itemFilterListNotifiers);
  // print('The stock count of item ${item.itemName} and count ${item.stock} is decreased by $quantity and now have $newStock');
}

void getTheFilterItem({int? limit, bool? isLess = true}) {
  if (limit != null) {
    itemFilterListNotifiers.value = itemModelListNotifiers.value
        .where(
          (element) =>
              isLess == true ? element.stock < limit : element.stock > limit,
        )
        .toList();
    if (limit == 0 && isLess == false) {
      outOfStockListNotifiers.value = itemFilterListNotifiers.value
          .map(
            (e) => e,
          )
          .toList();
    }
  } else {
    itemFilterListNotifiers.value = itemModelListNotifiers.value;
    // print('filter is worked');
  }
  notifyAnyListeners(itemFilterListNotifiers);
}

Future<List<ItemModel>> getTheOutOfStockItems([int? outOfStockLimit]) async {
  itemBox = await Hive.openBox<ItemModel>(ITEM_BOX);
  return itemBox.values.where(
    (element) => outOfStockLimit == null
        ? element.stock == 0
        : element.stock <= outOfStockLimit,
  ).toList();

  
}

void getTheItemFilteredByRange(double? start, double? end) {
  if (start != null && end != null) {
    log('item model list length             is : ${itemModelListNotifiers.value.length}');
    filteredItemModelList.value = itemModelListNotifiers.value
        .where(
            (element) => start <= element.itemPrice && end >= element.itemPrice)
        .toList();
    log('start and end filter by range is worked total filtered item is ${filteredItemModelList.value.length}');
  }

  notifyAnyListeners(filteredItemModelList);
}
