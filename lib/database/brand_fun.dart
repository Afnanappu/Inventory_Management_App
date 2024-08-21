import 'package:hive_flutter/hive_flutter.dart';
import 'package:inventory_management_app/models/item_model.dart';

//Name of the DB
// ignore: constant_identifier_names
const BRAND_BOX = 'BrandBox';

//Opened a box so we can use it any time.
late Box brandBox;

//Function to get all item brand from database and added to itemBrandListNotifiers.
Future<void> getAllItemBrandFromDB() async {
  brandBox = await Hive.openBox<ItemBrandModel>(BRAND_BOX);
  itemBrandListNotifiers.value.clear();
  itemBrandListNotifiers.value =
      brandBox.values.cast<ItemBrandModel>().toList();

  notifyBrandListeners();
  print('fetching all brands from database');
}

//Function to add brand to database
Future<void> addBrandToDB(ItemBrandModel brand) async {
  brandBox = await Hive.openBox<ItemBrandModel>(BRAND_BOX);
  brand.id = await brandBox.add(brand);
  getAllItemBrandFromDB();
  print(
      'A new brand is added to database and the brand id = ${brand.id} and the length of all brand is ${brandBox.values.length}');
}

//Function to delete brand from database.
Future<void> deleteBrandFromDB(int brandIndex) async {
  brandBox = await Hive.openBox<ItemBrandModel>(BRAND_BOX);
  await brandBox.deleteAt(brandIndex);
  getAllItemBrandFromDB();
  print('The brand in the index $brandIndex is deleted');
}

//Function to Edit brand from database.
Future<void> editBrandFromDB(
  int brandIndex,
  ItemBrandModel brand,
) async {
  brandBox = await Hive.openBox<ItemBrandModel>(BRAND_BOX);
  brandBox.putAt(brandIndex, brand);
  getAllItemBrandFromDB();
  print('The brand at index $brandIndex is edited');
}

//Created a function that can notify itemBrandListNotifiers.
void notifyBrandListeners() {
  itemBrandListNotifiers.notifyListeners();
}
