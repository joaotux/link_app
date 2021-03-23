import 'package:intl/intl.dart';

class MoneyFormat {
  static num parse(String value) {
    return NumberFormat("###0.00", "pt_BR").parse(value);
  }

  static String format(double value) {
    return NumberFormat.currency(locale: "pt_br", decimalDigits: 2, symbol: "")
        .format(value);
  }
}
