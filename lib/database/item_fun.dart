import 'package:hive_flutter/hive_flutter.dart';
import 'package:inventory_management_app/models/item_model.dart';

// ignore: constant_identifier_names
const ITEM_BOX = 'ItemBox';

//Opened a box for item so we can use it any time
late Box itemBox;

//Function to get all item from database and added to itemModelListNotifiers.
Future<void> getAllItemFormDB() async {
  itemBox = await Hive.openBox<ItemModel>(ITEM_BOX);
  itemModelListNotifiers.value.clear();
  itemModelListNotifiers.value = itemBox.values.cast<ItemModel>().toList();
  notifyItemListeners();
  print('fetching all items from database\nThe number of item in the DB is ${itemBox.values.length}');
}

//Function to add item to database
Future<void> addItemToDB(ItemModel item) async {
  itemBox = await Hive.openBox<ItemModel>(ITEM_BOX);
  item.id = await itemBox.add(item);

  getAllItemFormDB();
  print(
      'A new item is added to database and the item id = ${item.id} and the length of all brand is ${itemBox.values.length}');
}

//Function to delete from database.
Future<void> deleteItemFromDB(int itemIndex) async {
  itemBox = await Hive.openBox<ItemModel>(ITEM_BOX);
  await itemBox.deleteAt(itemIndex);
  getAllItemFormDB();
  print('The item in the index $itemIndex is deleted');
}

//Function to delete from database.
Future<void> editItemFromDB(int itemIndex, ItemModel item) async {
  itemBox = await Hive.openBox<ItemModel>(ITEM_BOX);
  await itemBox.putAt(itemIndex, item);
  getAllItemFormDB();
  print('The item in the index $itemIndex is edited');
}

//Created a function that can notify itemModelListNotifiers.
void notifyItemListeners() {
  itemModelListNotifiers.notifyListeners();
}
