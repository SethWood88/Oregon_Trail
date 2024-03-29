import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'Adjustables/globals.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage();

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[100],
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              'Sent Notifications',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: sentNotifications.length,
                itemBuilder: (BuildContext context, int index) {
                  final notification = sentNotifications[index];
                  return ListTile(
                    title: Text(notification),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
