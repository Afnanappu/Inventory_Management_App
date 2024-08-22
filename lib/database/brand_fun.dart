import 'package:hive_flutter/hive_flutter.dart';
import 'package:inventory_management_app/models/item_model.dart';

//Name of the DB
// ignore: constant_identifier_names
const BRAND_BOX = 'BrandBox';

//Opened a box so we can use it any time.
late Box<ItemBrandModel> brandBox;

//Function to get all item brand from database and added to itemBrandListNotifiers.
Future<void> getAllItemBrandFromDB() async {
  brandBox = await Hive.openBox<ItemBrandModel>(BRAND_BOX);
  itemBrandListNotifiers.value.clear();
  itemBrandListNotifiers.value =
      brandBox.values.cast<ItemBrandModel>().toList();
  // brandBox.clear();
  notifyBrandListeners();
  print(
      'fetching all brands from database\nThe number of brand in the DB is ${brandBox.values.length}');
}

//Function to add brand to database
Future<void> addBrandToDB(ItemBrandModel brand) async {
  brandBox = await Hive.openBox<ItemBrandModel>(BRAND_BOX);
  brand.id = await brandBox.add(brand);
  await brandBox.put(brand.id, brand);
  getAllItemBrandFromDB();
  print(
      'A new brand is added to database and the brand id = ${brand.id} and the length of all brand is ${brandBox.values.length}');
}

//Function to delete brand from database.
Future<void> deleteBrandFromDB(int brandId) async {
  brandBox = await Hive.openBox<ItemBrandModel>(BRAND_BOX);
  await brandBox.delete(brandId);
  getAllItemBrandFromDB();
  print(
      'The brand in the index $brandId is deleted. The available brands is ${brandBox.values.length}');
}

//Function to Edit brand from database.
Future<void> editBrandFromDB(
  int brandId,
  ItemBrandModel brand,
) async {
  brandBox = await Hive.openBox<ItemBrandModel>(BRAND_BOX);
  brandBox.put(brandId, brand);
  getAllItemBrandFromDB();
  print('The brand at index $brandId is edited');
}

//Created a function that can notify itemBrandListNotifiers.
void notifyBrandListeners() {
  itemBrandListNotifiers.notifyListeners();
}

Future<ItemBrandModel> findItemBrandFromDB(int brandId) async {
  brandBox = await Hive.openBox<ItemBrandModel>(BRAND_BOX);
  return brandBox.values.firstWhere(
    (brand) => brand.id == brandId,
  );
}
