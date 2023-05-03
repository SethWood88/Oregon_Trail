import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

Map<String, String> locationNicknames = {
  '1600 Amphitheatre Parkway, Mountain View, CA 94043': 'Google HQ',
  '1600 Pennsylvania Ave NW, Washington, DC 20500': 'The White House',
  '1600 Saratoga Ave, San Jose, CA 95129': 'Westgate Center',
  '9245 S Jefferson CV, Sandy, UT 84070': 'Utah Home Base',
};

Future<String> getClosestLocationNickname(int accuracy) async {
  Position position = await Geolocator.getCurrentPosition();
  String closestLocationNickname = '';
  double closestDistance = double.infinity;
  for (String location in locationNicknames.keys) {
    List<Location> locationPlacemarks = await locationFromAddress(location);
    Location locationPosition = locationPlacemarks.first;
    double distanceInMeters = Geolocator.distanceBetween(
      position.latitude,
      position.longitude,
      locationPosition.latitude,
      locationPosition.longitude,
    );
    if (distanceInMeters <= accuracy && distanceInMeters < closestDistance) {
      closestLocationNickname = locationNicknames[location];
      closestDistance = distanceInMeters;
    }
  }
  return closestLocationNickname;
}
