import 'package:hive_flutter/hive_flutter.dart';
import 'package:inventory_management_app/models/item_model.dart';

//Name of the DB
// ignore: constant_identifier_names
const BRAND_BOX = 'BrandBox';

//Opened a box so we can use it any time.
late Box brandBox;

//Function to add brand to database
Future<void> addBrandToDB(ItemBrandModel brand) async {
  brandBox = await Hive.openBox(BRAND_BOX);
  brand.id = await brandBox.add(brand);
  notifyBrandListeners();
}

//Function to get all item brand from database and added to itemBrandListNotifiers.
Future<void> getAllItemBrandFromDB() async {
  brandBox = await Hive.openBox(BRAND_BOX);
  itemBrandListNotifiers.value.clear();
  itemBrandListNotifiers.value =
      brandBox.values.cast<ItemBrandModel>().toList();

  notifyBrandListeners();
}

//Created a function that can notify itemBrandListNotifiers.
void notifyBrandListeners() {
  itemBrandListNotifiers.notifyListeners();
}
