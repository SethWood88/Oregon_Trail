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
      name: 'Magic Elixer',
      description: 'While stopping for lunch at a local diner, come up with a list of silly and creative soda combinations to try, and challenge each other to drink them all.',
      date: DateTime(2023, 5, 20, 12),
      proximityRadius: 0,
    ),
    TragedyEvent(
      id: 2,
      name: 'Undercover',
      description: 'While checking into your hotel, have a funny conversation pretending to be secret agents on a secret mission, and come up with silly and ridiculous codenames for each other.',
      location: LatLng(41.75239, -124.18949),
      proximityRadius: 100, // 100 Meters
    ),
    TragedyEvent(
      id: 3,
      name: 'Eye of my world',
      description: 'On the beach look for a rock or a shell that closest resembles the color of each others eye.',
      date: DateTime(2023, 5, 24, 14, 30),
      proximityRadius: 0,
    ),
    TragedyEvent(
      id: 4,
      name: 'Ummm like',
      description: 'While enjoying dinner at a local restaurant, come up with a list of funny and creative ways to describe the food you are eating, like "tastes like a unicorn tear" or "smells like leprechaun anus.',
      location: LatLng(41.74853, -124.18051),
      proximityRadius: 100,
    ),
    TragedyEvent(
      id: 5,
      name: 'Hello its me',
      description: 'Play some Adele while going through Adel.',
      location: LatLng(42.17785, -119.89958),
      proximityRadius: 1500,
    ),
    TragedyEvent(
      id: 6,
      name: 'Bit dry init',
      description: 'Not a drop in sight in this god forsaken desert, lets change that. Have a moaning competition.',
      location: LatLng(40.75210, -113.64349),
      proximityRadius: 2000,
    ),
    TragedyEvent(
      id: 7,
      name: 'Drew’s River',
      description: 'This is Drew’s reservoir. How you acquire a reservoir hell if i know, but drew did it.',
      location: LatLng(42.20483, -120.68956),
      proximityRadius: 500,
    ),  
    TragedyEvent(
      id: 8,
      name: 'Dissin’ Terry',
      description: 'Find the ugliest looking terrier dogs on the internet and make fun of them as much as you can.',
      date: DateTime(2023, 5, 23, 10, 30),
      proximityRadius: 0,
    ),
    TragedyEvent(
      id: 9,
      name: 'Historian',
      description: 'As you are passing a town, make up a story about how it got there and who is currently running it. Maybe like a breakdown of a town like in small town murder.',
      location: LatLng(40.74260, -115.94679),
      proximityRadius: 1000,
    ),
    TragedyEvent(
      id: 10,
      name: '(Dont read this out to Seth) Dysentery',
      description: '(Dont read this out to Seth) Just do something gross and unsettling towards Seth.',
      date: DateTime(2023, 5, 21, 13, 30),
      proximityRadius: 0,
    ),
    TragedyEvent(
      id: 11,
      name: 'Cholera',
      description: 'How do you make a woman angry and sick at the same time?',
      date: DateTime(2023, 5, 21, 17, 0),
      proximityRadius: 0,
    ),
    TragedyEvent(
      id: 12,
      name: 'Cholera, bitch. HAHAHA',
      description: 'That Joke was a tragedy in itself.',
      date: DateTime(2023, 5, 21, 17, 1),
      proximityRadius: 0,
    ),
    TragedyEvent(
      id: 13,
      name: 'Broken arm',
      description: 'For whatever is happening you can only use one arm for an hour. Goes for both of ya.',
      date: DateTime(2023, 5, 24, 9, 30),
      proximityRadius: 0,
    ),

    TragedyEvent(
      id: 14,
      name: 'Traffic jam',
      description: ' During a long drive, you encounter a sudden traffic jam that slows down your progress. use the opportunity play a game of "would you rather"',
      date: DateTime(2023, 5, 23, 12, 30),
      proximityRadius: 0,
    ),
    TragedyEvent(
      id: 15,
      name: 'Birds and the bees',
      description: 'Make some sweet sweet love',
      date: DateTime(2023, 5, 23, 20),
      proximityRadius: 0,
    ),
    TragedyEvent(
      id: 16,
      name: 'Gettin older',
      description: 'Happy Birthday Gorgeous! 20 is getting old. I might need to upgrade to a wife',
      date: DateTime(2023, 5, 22, 10),
      proximityRadius: 0,
    ),
    TragedyEvent(
      id: 17,
      name: 'Till next time',
      description: 'Thank you for joining me on this amazing Oregon Trail Experience. Cant wait for our next adventure. -Seth',
      date: DateTime(2023, 5, 27, 16, 30),
      proximityRadius: 200,
    ),
  ];
}
