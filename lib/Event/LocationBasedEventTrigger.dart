import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:oregon_trail/Event/Events.dart';


class LocationBasedEventTrigger {
  final FlutterLocalNotificationsPlugin notificationsPlugin;
  final double proximityRadius;

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
        await scheduleNotificationForEvent(event);
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
  }
}
