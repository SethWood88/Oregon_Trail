import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:oregon_trail/Event/Events.dart';
import 'package:timezone/timezone.dart' as tz;

class TimeBasedEventScheduler {
  final FlutterLocalNotificationsPlugin notificationsPlugin;
  final List<TragedyEvent> events;

  TimeBasedEventScheduler({
    @required this.notificationsPlugin,
    this.events,
  });

  void startPeriodicCheck() {
    Timer.periodic(Duration(seconds: 31), (timer) async {
      await checkEventsAndScheduleNotifications();
    });
  }

  Future<void> checkEventsAndScheduleNotifications() async {
    final currentTime = DateTime.now();
    for (TragedyEvent event in Events.demoTragedyEvents) {
      final eventTime = tz.TZDateTime.from(event.date, tz.local);
      final diff = eventTime.difference(currentTime).inMinutes;
      if (diff == 0) {
        // Event time has arrived, schedule notification
        await scheduleNotificationForEvent(event);
      }
    }
  }

  Future<void> scheduleNotificationForEvent(TragedyEvent event) async {
    final androidDetails = AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      'channel_description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    final platformDetails = NotificationDetails(android: androidDetails);

    await notificationsPlugin.zonedSchedule(
      event.id,
      event.name,
      event.description,
      tz.TZDateTime.from(event.date, tz.local),
      platformDetails,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}
