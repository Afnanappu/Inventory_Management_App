import 'package:hive_flutter/hive_flutter.dart';
import 'package:inventory_management_app/models/item_model.dart';

// ignore: constant_identifier_names
const ITEM_BOX = 'ItemBox';

//Opened a box for item so we can use it any time
late Box itemBox;

//Function to add item to database
Future<void> addItemToDB(ItemModel item) async {
  itemBox = await Hive.openBox<ItemModel>(ITEM_BOX);
  item.id = await itemBox.add(item);

  notifyItemListeners();
  print(
      'New item is added to itemModel DB and the length of all the item int the DB is: ${itemBox.values.length}');
}

//Function to get all item from database and added to itemModelListNotifiers.
Future<void> getAllItemFormDB() async {
  itemBox = await Hive.openBox<ItemModel>(ITEM_BOX);
  itemModelListNotifiers.value.clear();
  itemModelListNotifiers.value = itemBox.values.cast<ItemModel>().toList();
  notifyItemListeners();
}

//Created a function that can notify itemModelListNotifiers.
void notifyItemListeners() {
  itemModelListNotifiers.notifyListeners();
}


  // itemBrandListNotifiers.value =
  //     itemBrandBox.values.cast<ItemBrandModel>().toList();
  // itemModelListNotifiers.notifyListeners();
  // for (var i in itemBrandListNotifiers.value) {
  //   itemModelListNotifiers.value.addAll(i.itemModelList ?? []);
  // print('${i.itemModelList}');

  // }