import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inventory_management_app/screens/main_home_screen.dart';
import 'package:inventory_management_app/screens/first_screens/splash_screen.dart';
import 'package:inventory_management_app/screens/sub_screens/notification_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const InventoryManagementApp());
}

class InventoryManagementApp extends StatelessWidget {
  const InventoryManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      routes: {
        "/MainHomeScreen": (ctx) => const MainHomeScreen(),
        "/NotificationScreen": (ctx) => const NotificationScreen(),
      },
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Color.fromARGB(14, 0, 0, 0))
        )
      ),
    );
  }
}
