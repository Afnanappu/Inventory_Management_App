import 'package:inventory_management_app/database/sales_fun.dart';

enum CurrentDate { week, month, year }

void getTheCurrentDate(CurrentDate currentDate) {
  final today = DateTime.now();
  late DateTime startDate;
  DateTime? endDate;
  switch (currentDate) {
    case CurrentDate.week:
      final weekStart = today.weekday - 1;
      startDate = today.subtract(Duration(days: weekStart));
      endDate = startDate.add(Duration(days: weekStart + 6));
      print('This week');
      break;

    case CurrentDate.month:
      startDate = DateTime(today.year, today.month, 1);
      endDate = DateTime(today.year, today.month + 1, 1);
      print('This month');

    case CurrentDate.year:
      startDate = DateTime(today.year);
      print('This year');
    default:
  }
  getSalesBasedOnDateTime(startDate: startDate, endDate: endDate);
  getTheNumberOfItemSold(start: startDate, end: endDate);
  getThePriceAmountOfItemSold(start: startDate, end: endDate);
}
