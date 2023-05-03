import 'dart:io';
import 'package:flutter/material.dart';
import 'package:oregon_trail/Camera&Gallery/CameraWidget.dart';
import 'package:oregon_trail/ClosestLocationWidget.dart';
import 'package:oregon_trail/TaskWidget.dart';

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
              children: [],
            )));
  }
}
