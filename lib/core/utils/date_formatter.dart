import 'package:intl/intl.dart';

class DateFormatter {
  String formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    final aDate = DateTime(date.year, date.month, date.day);

    if (aDate == today) {
      return 'Today' + DateFormat(', h:mm a').format(date);
    } else if (aDate == yesterday) {
      return 'Yesterday' + DateFormat(', h:mm a').format(date);
    } else if (aDate == tomorrow) {
      return 'Tomorrow' + DateFormat(', h:mm a').format(date);
    } else {
      return DateFormat('MMM d, h:mm a').format(date);
    }
  }
}
