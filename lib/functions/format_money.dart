import 'package:intl/intl.dart';

String formatMoney({required double number, bool haveSymbol = true}) {
  String formattedMoney = NumberFormat.currency(
    locale: 'en_IN',
    symbol: haveSymbol == true ? '₹' : '',
    decimalDigits: 2,
  ).format(number);

  return formattedMoney;
}
