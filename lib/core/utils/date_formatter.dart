import 'package:intl/intl.dart';

class DateFormatter {
  static String formatDate(String date) {
    final parsedDate = DateTime.parse(date);
    return DateFormat("MMM dd,yyyy").format(parsedDate);
  }

  static String formatOrderDateTime(DateTime? date) {
    if (date == null) return 'Pending';
    return '${date.day}-${date.month}-${date.year}, '
        '${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }
}
