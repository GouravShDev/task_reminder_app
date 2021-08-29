import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

abstract class NotificationService {
  Future<void> showNotication({
    required int id,
    String? title,
    String? message,
    String? payload,
  });
  Future<void> scheduledNotification({
    required int id,
    String? title,
    String? message,
    String? payload,
    required DateTime scheduledDate,
  });
  Future<void> cancelNotification(int id);
}

class NotificationServiceImp implements NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  NotificationServiceImp(this.flutterLocalNotificationsPlugin);

  static Future _notificationDetails() async {
    return NotificationDetails(
      android: AndroidNotificationDetails(
          'id', 'Task', 'Show Notification for Your Task',
          color: Color.fromRGBO(41, 79, 121, 1), importance: Importance.max),
      iOS: IOSNotificationDetails(),
    );
  }

  @override
  Future<void> showNotication(
      {required int id,
      String? title,
      String? message,
      String? payload}) async {
    return flutterLocalNotificationsPlugin.show(
        id, title, message, await _notificationDetails(),
        payload: payload);
  }

  @override
  Future<void> scheduledNotification(
      {required int id,
      String? title,
      String? message,
      String? payload,
      required DateTime scheduledDate}) async {
    return flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        title,
        message,
        tz.TZDateTime.from(scheduledDate, tz.local),
        await _notificationDetails(),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        payload: payload);
  }

  @override
  Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }
}
