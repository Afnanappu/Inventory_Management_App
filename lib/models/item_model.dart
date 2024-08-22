import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'item_model.g.dart';

List<String> brandItemList = [
  'All',
  'iPhone',
  'Redmi',
  'Samsung',
  'OnePlus',
];

 ValueNotifier<List<ItemModel>> filteredItemModelList = ValueNotifier([]);

final all = ItemBrandModel(itemBrandName: 'All');

ValueNotifier<List<ItemBrandModel>> itemBrandListNotifiers =
    ValueNotifier([]);

ValueNotifier<List<ItemModel>> itemModelListNotifiers = ValueNotifier([]);

@HiveType(typeId: 1)
class ItemBrandModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String itemBrandName;
  ItemBrandModel({this.id, required this.itemBrandName});
}



@HiveType(typeId: 2)
class ItemModel {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String itemName;

  @HiveField(2)
  int brandId;

  @HiveField(3)
  String itemImage;

  @HiveField(4)
  double itemPrice;

  @HiveField(5)
  List<String> color;

  @HiveField(6)
  List<String> ram;

  @HiveField(7)
  List<String> rom;
  
  @HiveField(8)
  String description;

  @HiveField(9)
  int stock;

  ItemModel({
    required this.brandId,
    required this.itemName,
    required this.itemImage,
    required this.itemPrice,
    required this.color,
    required this.ram,
    required this.rom,
    required this.description,
    required this.stock,
  });
}


// class ItemStock {
//   int? id;
//   int stock;

//   ItemStock({required this.stock, this.id});
// }

// // ignore: constant_identifier_names
// enum ItemRAM { GB4, GB6, GB8 }

// // ignore: constant_identifier_names
// enum ItemROM { GB64, GB128, GB256 }

// // ignore: constant_identifier_names
// enum ItemCOLOR { Black, White, Blue }

// ItemModel(
//   itemName: 'OnePlus Nord 4 5G',
//   itemBrandName: brandItemList[4],
//   itemImage: 'assets/mobiles/OnePlus Nord 4 5G.png',
//   itemPrice: '₹32,998',
//   color: [colors[0]],
//   ram: [ram[0]],
//   rom: [rom[0]],
//   description: 'This is the description of this item',
//   stock: ItemStock(stock: '10'),
// ),
// ItemModel(
//   itemName: 'Redmi 13C 5G',
//   itemBrandName: brandItemList[2],
//   itemImage: 'assets/mobiles/Redmi 13C 5G.png',
//   itemPrice: '₹27,999',
//   color: [colors[0]],
//   ram: [ram[0]],
//   rom: [rom[0]],
//   description: 'This is the description of this item',
//   stock: ItemStock(stock: '10'),
// ),
// ItemModel(
//   itemName: 'Samsung Galaxy S23 Ultra',
//   itemBrandName: brandItemList[2],
//   itemImage: 'assets/mobiles/Samsung Galaxy S23 Ultra.png',
//   itemPrice: '₹84,999',
//   color: [colors[0]],
//   ram: [ram[0]],
//   rom: [rom[0]],
//   description: 'This is the description of this item',
//   stock: ItemStock(stock: '10'),
// ),
// ItemModel(
//   itemName: 'Apple iPhone 14 Plus',
//   itemBrandName: brandItemList[1],
//   itemImage: 'assets/mobiles/Apple iPhone 14 Plus.png',
//   itemPrice: '₹56,499',
//   color: [colors[0]],
//   ram: [ram[0]],
//   rom: [rom[0]],
//   description: 'This is the description of this item',
//   stock: ItemStock(stock: '10'),
// ),
// ItemModel(
//   itemName: 'OnePlus 12',
//   itemBrandName: brandItemList[1],
//   itemImage: 'assets/mobiles/OnePlus 12.png',
//   itemPrice: '₹56,499',
//   color: [colors[0]],
//   ram: [ram[0]],
//   rom: [rom[0]],
//   description: 'This is the description of this item',
//   stock: ItemStock(stock: '10'),
// ),
