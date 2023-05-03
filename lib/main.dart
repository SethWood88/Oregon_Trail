import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:oregon_trail/Camera&Gallery/PhotoGalleryPage.dart';
import 'package:oregon_trail/Event/event_initializer.dart';
import 'package:oregon_trail/notification_page.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:oregon_trail/Event/LocationBasedEventTrigger.dart';
import 'package:permission_handler/permission_handler.dart';
import 'Event/TimeBasedEventScheduler.dart';

import 'dashboard_page.dart';
import 'welcome_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

// Initialize Firebase App
  await Firebase.initializeApp();

// Request permission to access the device's location
  await Permission.location.request();

// Get the current location of the device
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);

// Get the current Time Zone
  tz.initializeTimeZones();

// Stupid Shit idk what it does but its needed for notifications
  await initializeEvents();

  runApp(MyApp(position: position));
}

class MyApp extends StatefulWidget {
  final Position position;

  const MyApp({this.position});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  PageController _pageController; // declare _pageController

  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
        initialPage: _currentPage); // create _pageController in initState

    // Start the periodic check for time-based events
    TimeBasedEventScheduler().startPeriodicCheck();
    LocationBasedEventTrigger().startListeningToLocationChanges();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MediaQuery(
        data: MediaQueryData(),
        child: Scaffold(
          backgroundColor: Colors.lightGreen[100],
          appBar: AppBar(
            toolbarHeight: 25,
            backgroundColor: Colors.green[900],
          ),
          body: PageView(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            children: [
              WelcomePage(),
              DashboardPage(),
              NotificationPage(),
              PhotoGalleryWidget(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.green[900],
            currentIndex: _currentPage,
            onTap: (int page) {
              _pageController.animateToPage(
                page,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
              );
            },
            selectedItemColor: Colors.lightGreen[100],
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.article_outlined),
                label: "Instructions",
                backgroundColor: Colors.green[900],
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.nature_people_rounded),
                label: "Dashboard",
                backgroundColor: Colors.green[900],
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                label: "Notifications",
                backgroundColor: Colors.green[900],
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.photo_album_rounded),
                label: "Photo Gallery",
                backgroundColor: Colors.green[900],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
