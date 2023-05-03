import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:oregon_trail/Adjustables/globals.dart';

class ClosestLocationWidget extends StatefulWidget {
  @override
  _ClosestLocationWidgetState createState() => _ClosestLocationWidgetState();

  static Future<String> getClosestLocationNickname() async {
    Position position = await Geolocator.getCurrentPosition();
    Map<String, double> locationDistances = {};

    for (String location in locationNicknames.keys) {
      List<Location> locationPlacemarks = await locationFromAddress(location);
      Location locationPosition = locationPlacemarks.first;
      double distanceInMeters = Geolocator.distanceBetween(
        position.latitude,
        position.longitude,
        locationPosition.latitude,
        locationPosition.longitude,
      );
      if (distanceInMeters <= 500) {
        locationDistances[location] = distanceInMeters;
      }
    }

    if (locationDistances.isNotEmpty) {
      List<MapEntry<String, double>> sortedDistances =
      locationDistances.entries.toList()
        ..sort((a, b) => a.value.compareTo(b.value));
      String closestLocation = sortedDistances.first.key;
      return locationNicknames[closestLocation] ?? '';
    } else {
      return '';
    }
  }

  static List<String> getTasksForLocation(String locationNickname) {
    switch (locationNickname) {
      case 'Google HQ':
        return ['Task 1 for Google HQ', 'Task 2 for Google HQ', 'Task 3 for Google HQ'];
      case 'The White House':
        return ['Task 1 for The White House', 'Task 2 for The White House', 'Task 3 for The White House'];
      case 'Westgate Center':
        return ['Task 1 for Westgate Center', 'Task 2 for Westgate Center', 'Task 3 for Westgate Center'];
      case 'Utah Home Base':
        return ['All Ready To Go?', 'Find a Homeless man and give him some ice cream', 'Dont die', 'Make your bed', "Have a slumber party"];
      default:
        return [];
    }
  }
}

class _ClosestLocationWidgetState extends State<ClosestLocationWidget> {
  String _closestLocationNickname = '';

  @override
  void initState() {
    super.initState();
    _getClosestLocationNickname();
  }

  Future<void> _getClosestLocationNickname() async {
    _closestLocationNickname = await ClosestLocationWidget.getClosestLocationNickname();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_closestLocationNickname.isNotEmpty) {
      return Text(
        '$_closestLocationNickname',
        style: TextStyle(
          fontSize: 24.0,
          color: Colors.brown[700],
          fontWeight: FontWeight.bold,
        ),
      );
    } else {
      return Text(
        'Not at Destination',
        style: TextStyle(
          fontSize: 24.0,
          color: Colors.brown[700],
          fontWeight: FontWeight.bold,
        ),
      );
    }
  }
}
