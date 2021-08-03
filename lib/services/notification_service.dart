import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final _notifications = FlutterLocalNotificationsPlugin();

  static Future initalilize() async {
    final InitializationSettings initializationSettings =
        new InitializationSettings(
      android: AndroidInitializationSettings('ic_app_logo'),
      iOS: IOSInitializationSettings(),
    );
    await _notifications.initialize(initializationSettings);
    tz.initializeTimeZones();
  }

  static Future _notificationDetails() async {
    return NotificationDetails(
      android: AndroidNotificationDetails(
          'id', 'Task', 'Show Notification for Your Task',
          color: Color.fromRGBO(41, 79, 121, 1), importance: Importance.max),
      iOS: IOSNotificationDetails(),
    );
  }

  static Future showNotification(
          {required int id,
          String? title,
          String? message,
          String? payload}) async =>
      _notifications.show(id, title, message, await _notificationDetails(),
          payload: payload);

  static Future scheduledNotification({
    required int id,
    String? title,
    String? message,
    String? payload,
    required DateTime scheduledDate,
  }) async =>
      _notifications.zonedSchedule(
          id,
          title,
          message,
          tz.TZDateTime.from(scheduledDate, tz.local),
          await _notificationDetails(),
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          payload: payload);

  static Future cancelScheduledNotification(int? id) async {
    print('id is $id');
    if (id != null) {
      print('Cancelling Scheduled Notification');
      await _notifications.cancel(id);
    }
  }
}
