import 'package:intl/intl.dart';

class CurrencyUtils {
  static String formatCurrency(double amount) {
    final formatter = NumberFormat('#,###', 'id_ID');
    return 'Rp ${formatter.format(amount)}';
  }
}