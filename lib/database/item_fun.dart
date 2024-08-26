import 'package:hive_flutter/hive_flutter.dart';
import 'package:inventory_management_app/functions/generate_unique_id.dart';
import 'package:inventory_management_app/models/item_model.dart';

// ignore: constant_identifier_names
const ITEM_BOX = 'ItemBox';

//Opened a box for item so we can use it any time
late Box<ItemModel> itemBox;

//Function to get all item from database and added to itemModelListNotifiers.
Future<void> getAllItemFormDB() async {
  itemBox = await Hive.openBox<ItemModel>(ITEM_BOX);
  itemModelListNotifiers.value.clear();
  itemModelListNotifiers.value = itemBox.values.cast<ItemModel>().toList();
  // itemBox.clear();
  notifyItemListeners();
  print(
      'fetching all items from database\nThe number of item in the DB is ${itemBox.values.length}');
}

//Function to add item to database
Future<void> addItemToDB(ItemModel item) async {
  itemBox = await Hive.openBox<ItemModel>(ITEM_BOX);

  item.id = generateUniqueId();
  await itemBox.put(item.id, item);

  await getAllItemFormDB();
  print(
      'A new item is added to database and the item id = ${item.id} and the brand id is = ${item.brandId} and the length of all item is ${itemBox.values.length}');
}

//Function to delete from database.
Future<void> deleteItemFromDB(int itemId) async {
  itemBox = await Hive.openBox<ItemModel>(ITEM_BOX);
  await itemBox.delete(itemId);

  getAllItemFormDB();
  print(
      'The item in the index $itemId is deleted and the length of all item is ${itemBox.values.length}');
}

//Function to delete from database.
Future<void> editItemFromDB(int itemId, ItemModel item) async {
  itemBox = await Hive.openBox<ItemModel>(ITEM_BOX);
  await itemBox.put(itemId, item);

  getAllItemFormDB();
  print('The item in the index $itemId is edited');
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
  print('The stock count of item ${item.itemName} and count ${item.stock} is decreased by $quantity and now have $newStock');
}

//Created a function that can notify itemModelListNotifiers.
void notifyItemListeners() {
  itemModelListNotifiers.notifyListeners();
}
