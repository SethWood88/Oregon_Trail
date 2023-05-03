import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationService extends StatefulWidget {
  const LocationService({Key key}) : super(key: key);

  @override
  _LocationServiceState createState() => _LocationServiceState();
}

class _LocationServiceState extends State<LocationService> {
   Location location;
   bool _serviceEnabled;
   PermissionStatus _permissionGranted;
   LocationData _locationData;

  @override
  void initState() {
    super.initState();
    location = Location();
    checkLocationPermissions();
  }

  Future<void> checkLocationPermissions() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location Service'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Latitude: ${_locationData.latitude}',
              style: Theme.of(context).textTheme.headline5,
            ),
            Text(
              'Longitude: ${_locationData.longitude}',
              style: Theme.of(context).textTheme.headline5,
            ),
          ],
        ),
      ),
    );
  }
}