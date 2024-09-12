import 'dart:developer';
import 'package:inventory_management_app/functions/notification_functions.dart';
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:inventory_management_app/constants/colors.dart';
import 'package:inventory_management_app/models/customer_model.dart';
import 'package:inventory_management_app/models/item_model.dart';
import 'package:inventory_management_app/models/profile_model.dart';
import 'package:inventory_management_app/screens/first_screens/password_screen.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Future<void> onDidReceiveNotificationResponse(
      int id, String? title, String? body, String? payload) async {
    // id = 0;
    // title = 'Notification for IOS';
    // body = 'This is a sample notification for IOS devices';
    // payload = "I don't know what is this payload";
    log('iOS Notification: $title, $body, $payload');
  }

  Future<void> onSelectNotification(NotificationResponse response) async {
    // Handle notification tap
    print('Notification clicked with payload: ${response.payload}');
  }

  await requestExactAlarmPermission();

  var initializationSettingsAndroid =
      const AndroidInitializationSettings("@mipmap/app_icon");
  var initializationSettingsIOS = DarwinInitializationSettings(
      onDidReceiveLocalNotification: onDidReceiveNotificationResponse);
  var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

  tz_data.initializeTimeZones();

  flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.requestNotificationsPermission();

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: onSelectNotification,
  );

  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(ProfileModelAdapter().typeId)) {
    Hive.registerAdapter(ProfileModelAdapter());
  }
  if (!Hive.isAdapterRegistered(ItemBrandModelAdapter().typeId)) {
    Hive.registerAdapter(ItemBrandModelAdapter());
  }
  if (!Hive.isAdapterRegistered(ItemModelAdapter().typeId)) {
    Hive.registerAdapter(ItemModelAdapter());
  }
  if (!Hive.isAdapterRegistered(CustomerModelAdapter().typeId)) {
    Hive.registerAdapter(CustomerModelAdapter());
  }
  if (!Hive.isAdapterRegistered(SaleModelAdapter().typeId)) {
    Hive.registerAdapter(SaleModelAdapter());
  }
  if (!Hive.isAdapterRegistered(ReturnSaleModelAdapter().typeId)) {
    Hive.registerAdapter(ReturnSaleModelAdapter());
  }

  runApp(const InventoryManagementApp());
  
  checkOutOfStockItem();
}

class InventoryManagementApp extends StatelessWidget {
  const InventoryManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const PasswordScreen(),
      theme: ThemeData(
        iconTheme: const IconThemeData(color: MyColors.blackShade),
        scaffoldBackgroundColor: MyColors.white,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: MyColors.blackShade),
          bodyMedium: TextStyle(color: MyColors.blackShade),
          bodySmall: TextStyle(color: MyColors.blackShade),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: MyColors.white,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.black12,
          ),
        ),
      ),
    );
  }
}
