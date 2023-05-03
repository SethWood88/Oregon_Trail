import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:oregon_trail/Adjustables/globals.dart';

class GeoService {
  static Future<String> getClosestLocation() async {
    // Get the current position of the user
    Position position = await Geolocator.getCurrentPosition();

    // Compute the distance between the user's position and each location
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
      locationDistances[location] = distanceInMeters;
    }

    // Sort the locations by distance and return the closest one
    List<MapEntry<String, double>> sortedDistances =
    locationDistances.entries.toList()..sort((a, b) => a.value.compareTo(b.value));
    return locationNicknames[sortedDistances.first.key] ?? '';
  }
}