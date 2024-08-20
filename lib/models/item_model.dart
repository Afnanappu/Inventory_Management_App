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

// List<String> colors = ['Black', 'White', 'Yellow'];
// List<String> ram = ['4', '8', '16'];
// List<String> rom = ['32', '64', '128'];

ValueNotifier<List<ItemBrandModel>> itemBrandListNotifiers = ValueNotifier([]);

ValueNotifier<List<ItemModel>> itemModelListNotifiers = ValueNotifier([]);



@HiveType(typeId: 1)
class ItemBrandModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String itemBrandName;
  ItemBrandModel({this.id, required this.itemBrandName});
}

// class ItemStock {
//   int? id;
//   int stock;

//   ItemStock({required this.stock, this.id});
// }

// ignore: constant_identifier_names
enum ItemRAM { GB4, GB6, GB8 }

// ignore: constant_identifier_names
enum ItemROM { GB64, GB128, GB256 }

// ignore: constant_identifier_names
enum ItemCOLOR { Black, White, Blue }

@HiveType(typeId: 2)
class ItemModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String itemName;
  @HiveField(2)
  String itemBrand;
  @HiveField(3)
  String itemImage;
  @HiveField(4)
  double itemPrice;
  @HiveField(5)
  List<ItemCOLOR> color;
  @HiveField(6)
  List<ItemRAM> ram;
  @HiveField(7)
  List<ItemROM> rom;
  @HiveField(8)
  String description;
  @HiveField(9)
  int stock;

  ItemModel({
    required this.itemName,
    required this.itemBrand,
    required this.itemImage,
    required this.itemPrice,
    required this.color,
    required this.ram,
    required this.rom,
    required this.description,
    required this.stock,
  });
}

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
