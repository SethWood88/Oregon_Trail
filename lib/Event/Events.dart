import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TragedyEvent {
  final int id;
  final String name;
  final String description;
  final DateTime date;
  final LatLng location;
  final int proximityRadius;

  TragedyEvent({
    @required this.id,
    @required this.name,
    @required this.description,
    this.date,
    this.location,
    this.proximityRadius,
  });
}

class Events {
  static final List<TragedyEvent> demoTragedyEvents = [
    TragedyEvent(
      id: 1,
      name: 'Tragedy has struck',
      description: 'Do 20 jumping jacks',
      date: DateTime(2023, 4, 26, 13, 02), // 5pm on April 25, 2023
      proximityRadius: 0, // no proximity check needed for time-based event
    ),
    TragedyEvent(
      id: 2,
      name: 'Location-based event',
      description: 'Do 20 jumping jacks',
      location: LatLng(40.58328, -111.90995), // Home Base
      proximityRadius: 2000, // 2 km
    )
  ];
}
