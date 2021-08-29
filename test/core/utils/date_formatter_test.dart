import 'package:flutter_test/flutter_test.dart';
import 'package:todo_list/core/utils/date_formatter.dart';

void main() {
  late DateFormatter dateFormatter;

  setUp(() {
    dateFormatter = DateFormatter();
  });

  group('formateDate', () {
    test(
        'should return a date in {Month day, HH:MM AM/PM} format when date is not today or yesterday or tomorrow',
        () {
      final tdate = DateTime.parse('2020-01-01T01:10:00.000Z');
      final result = dateFormatter.formatDate(tdate);
      expect(result, 'Jan 1, 1:10 AM');
    });

    test(
        'should return a date in {Today, HH:MM AM/PM} format when date is today',
        () {
      final now = DateTime.now();
      final tdate = DateTime(now.year, now.month, now.day, 1, 10);
      final result = dateFormatter.formatDate(tdate);
      expect(result, 'Today, 1:10 AM');
    });

    test(
        'should return a date in {Yesterday, HH:MM AM/PM} format when date is yesterday',
        () {
      final now = DateTime.now();
      final tdate = DateTime(now.year, now.month, now.day - 1, 1, 10);
      final result = dateFormatter.formatDate(tdate);
      expect(result, 'Yesterday, 1:10 AM');
    });

    test(
        'should return a date in {Tomorrow, HH:MM AM/PM} format when date is tomorrow',
        () {
      final now = DateTime.now();
      final tdate = DateTime(now.year, now.month, now.day + 1, 1, 10);
      final result = dateFormatter.formatDate(tdate);
      expect(result, 'Tomorrow, 1:10 AM');
    });
  });
}
