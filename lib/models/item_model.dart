import 'package:flutter/material.dart';

List<String> brandItemList = [
  'All',
  'iPhone',
  'Redmi',
  'Samsung',
  'OnePlus',
];

List<String> itemNameList = [
  'OnePlus Nord 4 5G',
  'Redmi 13C 5G',
  'Samsung Galaxy S23 Ultra',
  'Apple iPhone 14 Plus'
];

List<String> itemImageList = [
  'assets/mobiles/OnePlus Nord 4 5G.png',
  'assets/mobiles/Redmi 13C 5G.png',
  'assets/mobiles/Samsung Galaxy S23 Ultra.png',
  'assets/mobiles/Apple iPhone 14 Plus.png',
  'assets/mobiles/OnePlus 12.png',
];

List<String> itemPriceList = [
  '₹32,998',
  '₹27,999',
  '₹84,999',
  '₹56,499',
];

List<ItemModel> itemModelList = [
  ItemModel(
      itemName: itemNameList[0],
      itemBrandName: brandItemList[4],
      itemImage: itemImageList[0],
      itemPrice: itemPriceList[0]),
  ItemModel(
      itemName: itemNameList[1],
      itemBrandName: brandItemList[2],
      itemImage: itemImageList[1],
      itemPrice: itemPriceList[1]),
  ItemModel(
      itemName: itemNameList[2],
      itemBrandName: brandItemList[2],
      itemImage: itemImageList[2],
      itemPrice: itemPriceList[2]),
  ItemModel(
      itemName: itemNameList[3],
      itemBrandName: brandItemList[1],
      itemImage: itemImageList[3],
      itemPrice: itemPriceList[3]),
];

class ItemModel {
  String itemName;
  String itemBrandName;
  String itemImage;
  String itemPrice;

  ItemModel(
      {required this.itemName,
      required this.itemBrandName,
      required this.itemImage,
      required this.itemPrice});
}

abstract class WorkoutPlan {
  String get workoutName;
  int get duration; // duration in minutes
  String get difficultyLevel;
}

class Beginner implements WorkoutPlan {
  @override
  final String workoutName;
  @override
  final int duration;
  @override
  final String difficultyLevel;
  Beginner(
      {required this.workoutName,
      required this.duration,
      required this.difficultyLevel});
}

class Intermediate implements WorkoutPlan {
  @override
  final String workoutName;
  @override
  final int duration;
  @override
  final String difficultyLevel;
  Intermediate(
      {required this.workoutName,
      required this.duration,
      required this.difficultyLevel});
}

class Advanced implements WorkoutPlan {
  @override
  final String workoutName;
  @override
  final int duration;
  @override
  final String difficultyLevel;
  Advanced(
      {required this.workoutName,
      required this.duration,
      required this.difficultyLevel});
}



List<WorkoutPlan> beginnerWorkout = [
  Beginner(
      workoutName: "Beginner workout",
      duration: 10,
      difficultyLevel: "beginner")
];
List<WorkoutPlan> intermediateWorkout = [
  Intermediate(
      workoutName: 'Intermediate workout',
      duration: 20,
      difficultyLevel: 'Intermediate')
];
List<WorkoutPlan> advancedWorkout = [
  Advanced(
      workoutName: 'Advanced workout',
      duration: 30,
      difficultyLevel: 'Advanced')
];

class WorkoutForAll extends StatelessWidget {
  const WorkoutForAll({super.key, required this.workout});
  final List<WorkoutPlan> workout;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(workout[0].workoutName),
        Text(workout[0].duration.toString())
      ],
    );
  }
}