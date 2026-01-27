import 'package:intl/intl.dart';

class DateFormatter {
  static String formatDate(String date) {
    final parsedDate = DateTime.parse(date);
    return DateFormat("MMM dd,yyyy").format(parsedDate);
  }
}
