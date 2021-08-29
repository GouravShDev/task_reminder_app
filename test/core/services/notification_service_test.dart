import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_list/core/services/notification_service.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'notification_service_test.mocks.dart';

@GenerateMocks([FlutterLocalNotificationsPlugin])
void main() {
  late NotificationServiceImp notificationServiceImp;
  late MockFlutterLocalNotificationsPlugin mockFlutterLocalNotificationsPlugin;

  setUp(() {
    mockFlutterLocalNotificationsPlugin = MockFlutterLocalNotificationsPlugin();
    notificationServiceImp =
        NotificationServiceImp(mockFlutterLocalNotificationsPlugin);
    tz.initializeTimeZones();
  });

  test('should call show when show Notification called', () async {
    // act
    await notificationServiceImp.showNotication(id: 1);

    // assert
    verify(mockFlutterLocalNotificationsPlugin.show(any, any, any, any));
  });
  test('should call scheduledNotification when notification is scheduled',
      () async {
    // act
    await notificationServiceImp.scheduledNotification(
        id: 1, scheduledDate: DateTime.now());

    // assert
    verify(mockFlutterLocalNotificationsPlugin.zonedSchedule(
        any, any, any, any, any,
        androidAllowWhileIdle: anyNamed('androidAllowWhileIdle'),
        payload: anyNamed('payload'),
        uiLocalNotificationDateInterpretation:
            anyNamed('uiLocalNotificationDateInterpretation')));
  });
  test('should call notification.ca when show notification schedule is cancel',
      () async {
    // act
    await notificationServiceImp.cancelNotification(1);

    // assert
    verify(mockFlutterLocalNotificationsPlugin.cancel(any));
  });
}
