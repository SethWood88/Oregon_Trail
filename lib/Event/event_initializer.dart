import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:oregon_trail/Event/TimeBasedEventScheduler.dart';
import 'package:oregon_trail/Event/LocationBasedEventTrigger.dart';

FlutterLocalNotificationsPlugin _notificationsPlugin;

Future<void> initializeEvents() async {
  _notificationsPlugin = FlutterLocalNotificationsPlugin();
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('launch_background');
  final InitializationSettings initializationSettings =
  InitializationSettings(android: initializationSettingsAndroid);
  await _notificationsPlugin.initialize(initializationSettings);

  final timeBasedEventScheduler = TimeBasedEventScheduler(
    notificationsPlugin: _notificationsPlugin,
  );
  timeBasedEventScheduler.startPeriodicCheck();

  final locationBasedEventTrigger = LocationBasedEventTrigger(
    notificationsPlugin: _notificationsPlugin,
  );
  locationBasedEventTrigger.startListeningToLocationChanges();
}
