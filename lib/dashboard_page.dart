import 'dart:io';
import 'package:flutter/material.dart';
import 'package:oregon_trail/Camera&Gallery/CameraWidget.dart';
import 'package:oregon_trail/ClosestLocationWidget.dart';
import 'package:oregon_trail/TaskWidget.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage();

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  File _imageFile;

  void _handlePictureTaken(File image) {
    print('Picture taken: $image');
    setState(() {
      _imageFile = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[100],
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Text(
                  "Current Location:",
                  style: TextStyle(color: Colors.green[900], fontSize: 20),
                ),
                const SizedBox(width: 10),
                ClosestLocationWidget(),
              ],
            ),
            Expanded(
              child: TaskWidget(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green[900],
        onPressed: () async {
          final imageFile = await Navigator.push<File>(
            context,
            MaterialPageRoute(
              builder: (context) => CameraWidget(
                onPictureTaken: _handlePictureTaken,
              ),
            ),
          );
          if (imageFile != null) {
            // Do something with the image file
          }
        },
        tooltip: 'Take a Photo',
        child: Icon(Icons.camera_alt_rounded),
      ),
    );
  }
}
