import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

Map<String, String> locationNicknames = {
  '26698 OR-62, Trail, OR 97541': 'Trail Oregon AirBnB',
  'Ocean View Inn, 270 US-101, Crescent City, CA 95531': 'Ocean View',
  '6855 S Virginia St, Reno, NV 89511': 'Reno Hotel',
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

List<String> sentNotifications = [];
