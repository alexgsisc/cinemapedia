import 'package:intl/intl.dart';

class HumanFormat {
  static String number(double number) {
    return NumberFormat.currency(
      decimalDigits: 0,
      symbol: null,
      locale: 'en',
    ).format(number);
  }
}
