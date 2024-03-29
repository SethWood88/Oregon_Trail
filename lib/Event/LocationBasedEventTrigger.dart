import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:oregon_trail/Event/Events.dart';
import '../Adjustables/globals.dart';

class LocationBasedEventTrigger {
  final FlutterLocalNotificationsPlugin notificationsPlugin;
  final double proximityRadius;
  DateTime lastNotificationSentTime;

  LocationBasedEventTrigger({
    this.notificationsPlugin,
    this.proximityRadius = 500, // default proximity radius in meters
  });

  void startListeningToLocationChanges() {
    Geolocator.getPositionStream(
      desiredAccuracy: LocationAccuracy.high,
      distanceFilter: 10, // update location when user moves by 10 meters
    ).listen((Position position) async {
      await checkEventsAndScheduleNotifications(position);
    });
  }

  Future<void> checkEventsAndScheduleNotifications(
      Position currentPosition) async {
    for (var event in Events.demoTragedyEvents) {
      if (event.proximityRadius == 0) {
        // Event does not require proximity check
        continue;
      }

      final distance = await Geolocator.distanceBetween(
        currentPosition.latitude,
        currentPosition.longitude,
        event.location.latitude,
        event.location.longitude,
      );

      if (distance <= event.proximityRadius) {
        // Within proximity radius, schedule notification
        if (lastNotificationSentTime != null) {
          // Check if enough time has passed since last notification
          final timeSinceLastNotification =
          DateTime.now().difference(lastNotificationSentTime);
          if (timeSinceLastNotification.inSeconds < 30) {
            continue; // Skip this event if not enough time has passed
          }
        }
        await scheduleNotificationForEvent(event);
        lastNotificationSentTime = DateTime.now();
      }
    }
  }

  Future<void> scheduleNotificationForEvent(TragedyEvent event) async {
    final androidDetails = AndroidNotificationDetails(
        'channel_id', 'channel_name', 'channel_description',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        color: Colors.green[900]);

    final platformDetails = NotificationDetails(android: androidDetails);

    await notificationsPlugin.show(
      event.id,
      event.name,
      event.description,
      platformDetails,
      payload: event.id.toString(),
    );

    sentNotifications
        .add('${event.name} - ${event.description} - ${DateTime.now()}');
  }
}
