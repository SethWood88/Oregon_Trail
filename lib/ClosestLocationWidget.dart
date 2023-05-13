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
      case 'Trail Oregon AirBnB':
        return ['Find a mushroom', 'Take a quick dip in the river', 'Wave at the house as you go by', 'Roast some marshmallows', 'Have seth teach you a new skill and you dont complain', 'Take a pictue of the wildlife', 'Take a picture of yourselves here', 'Have amazing shower sex, if there is one lol', "Play some games in the game room"];
      case 'Ocean View':
        return ['Get in that jacuzzi baby', 'Walk around the city', 'Take a photo of us with our view', 'Record audio for our kids. Something short and sweet', 'Take a picture of all the animals you can find. Maybe even a seal if you are lucky'];
      case 'Reno Hotel':
        return ['Take a pic of that ring baby', 'More sex if not too tired', 'Might as well pick up some weed', 'Cuddle for at least 30 minutes'];
      case 'Utah Home Base':
        return ['I Love you','I Love you', 'I Love you', 'I Love you', 'I Love you', 'I Love you', 'I Love you', 'I Love you', 'I Love you', 'I Love you', 'I Love you', 'I Love you', 'I Love you', 'I Love you', 'I Love you', 'I Love you', 'I Love you', 'I Love you', 'I Love you', 'I Love you', 'I Love you', 'I Love you', 'I Love you',];
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
