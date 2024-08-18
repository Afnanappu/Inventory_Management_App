import 'package:flutter/material.dart';

List<String> brandItemList = [
  'All',
  'iPhone',
  'Redmi',
  'Samsung',
  'OnePlus',
];

List<String> colors = ['Black', 'White', 'Yellow'];
List<String> ram = ['4', '8', '16'];
List<String> rom = ['32', '64', '128'];


ValueNotifier<List<ItemModel>> itemModelList = ValueNotifier([
  ItemModel(
    itemName: 'OnePlus Nord 4 5G',
    itemBrandName: brandItemList[4],
    itemImage: 'assets/mobiles/OnePlus Nord 4 5G.png',
    itemPrice: '₹32,998',
    color: [colors[0]],
    ram: [ram[0]],
    rom: [rom[0]],
    description: 'This is the description of this item',
    stock: ItemStock(stock: '10'),
  ),
  ItemModel(
    itemName: 'Redmi 13C 5G',
    itemBrandName: brandItemList[2],
    itemImage: 'assets/mobiles/Redmi 13C 5G.png',
    itemPrice: '₹27,999',
    color: [colors[0]],
    ram: [ram[0]],
    rom: [rom[0]],
    description: 'This is the description of this item',
    stock: ItemStock(stock: '10'),
  ),
  ItemModel(
    itemName: 'Samsung Galaxy S23 Ultra',
    itemBrandName: brandItemList[2],
    itemImage: 'assets/mobiles/Samsung Galaxy S23 Ultra.png',
    itemPrice: '₹84,999',
    color: [colors[0]],
    ram: [ram[0]],
    rom: [rom[0]],
    description: 'This is the description of this item',
    stock: ItemStock(stock: '10'),
  ),
  ItemModel(
    itemName: 'Apple iPhone 14 Plus',
    itemBrandName: brandItemList[1],
    itemImage: 'assets/mobiles/Apple iPhone 14 Plus.png',
    itemPrice: '₹56,499',
    color: [colors[0]],
    ram: [ram[0]],
    rom: [rom[0]],
    description: 'This is the description of this item',
    stock: ItemStock(stock: '10'),
  ),
  ItemModel(
    itemName: 'OnePlus 12',
    itemBrandName: brandItemList[1],
    itemImage: 'assets/mobiles/OnePlus 12.png',
    itemPrice: '₹56,499',
    color: [colors[0]],
    ram: [ram[0]],
    rom: [rom[0]],
    description: 'This is the description of this item',
    stock: ItemStock(stock: '10'),
  ),
]);

class ItemStock {
  int? id;
  String stock;

  ItemStock({required this.stock, this.id});
}

class ItemModel {
  int? id;
  String itemName;
  String itemBrandName;
  String itemImage;
  String itemPrice;
  List<String> color;
  List<String> ram;
  List<String> rom;
  String description;
  ItemStock stock;

  ItemModel({
    required this.itemName,
    required this.itemBrandName,
    required this.itemImage,
    required this.itemPrice,
    required this.color,
    required this.ram,
    required this.rom,
    required this.description,
    required this.stock,
  });
}

// abstract class WorkoutPlan {
//   String get workoutName;
//   int get duration; // duration in minutes
//   String get difficultyLevel;
// }

// class Beginner implements WorkoutPlan {
//   @override
//   final String workoutName;
//   @override
//   final int duration;
//   @override
//   final String difficultyLevel;
//   Beginner(
//       {required this.workoutName,
//       required this.duration,
//       required this.difficultyLevel});
// }

// class Intermediate implements WorkoutPlan {
//   @override
//   final String workoutName;
//   @override
//   final int duration;
//   @override
//   final String difficultyLevel;
//   Intermediate(
//       {required this.workoutName,
//       required this.duration,
//       required this.difficultyLevel});
// }

// class Advanced implements WorkoutPlan {
//   @override
//   final String workoutName;
//   @override
//   final int duration;
//   @override
//   final String difficultyLevel;
//   Advanced(
//       {required this.workoutName,
//       required this.duration,
//       required this.difficultyLevel});
// }

// List<WorkoutPlan> beginnerWorkout = [
//   Beginner(
//       workoutName: "Beginner workout",
//       duration: 10,
//       difficultyLevel: "beginner")
// ];
// List<WorkoutPlan> intermediateWorkout = [
//   Intermediate(
//       workoutName: 'Intermediate workout',
//       duration: 20,
//       difficultyLevel: 'Intermediate')
// ];
// List<WorkoutPlan> advancedWorkout = [
//   Advanced(
//       workoutName: 'Advanced workout',
//       duration: 30,
//       difficultyLevel: 'Advanced')
// ];

// class WorkoutForAll extends StatelessWidget {
//   const WorkoutForAll({super.key, required this.workout});
//   final List<WorkoutPlan> workout;
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Text(workout[0].workoutName),
//         Text(workout[0].duration.toString())
//       ],
//     );
//   }
// }
