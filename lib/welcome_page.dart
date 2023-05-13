import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage();

  @override
  Widget build(BuildContext context) {
    return PageView(
      scrollDirection: Axis.vertical,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            Text(
              "Welcome to",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.green[900],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Seth's Oregon Trail Experience!",
              style: TextStyle(
                fontSize: 24,
                color: Colors.green[900],
              ),
            ),
            Expanded(
              child: Container(
                width: 390,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(25)),
                child: Image.asset(
                  "assets/images/OregonGIF.gif",
                ),
              ),
            ),
            Text(
              "Swipe up for instructions",
              style: TextStyle(
                fontSize: 20,
                color: Colors.green[900],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
        Column(
          children: [
            const SizedBox(height: 20),
            const Divider(color: Colors.black, thickness: 3),
            Text(
              "Instructions",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.green[900],
              ),
            ),
            const Divider(color: Colors.black, thickness: 3),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        "These are the rules of the game:",
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "1. Tragedies: This is the Oregon trail after all, bad things may happen. These are called Tragedies. These will randomly happen at random times to one of us randomly. This will go on throughout the whole journey. (You must do what they say.)",
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "2. Random Events: Sometimes life gets boring at times and you need things to do.",
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "3. Timing: Keeping a tight schedule will be important for this to work but dont worry there is plenty of downtime throughout.",
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "4. Remember to just have fun and listen and follow your guide (Seth) if you want to come out of this alive. ",
                        style: TextStyle(fontSize: 20),
                      ),
                      Divider(color: Colors.black, thickness: 3),
                      const SizedBox(height: 20),
                      Text(
                        "Dashboard: When you reach a main location you will have a set of tasks to complete. Check there every time you stop at an important location.",
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Notifications: You will be notified when any type of event occures. Sometimes the event descriptions are lengthy so they will appear on the notifications page as well if you miss them.",
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Gallery: Take lots of photos. They will be captured in the gallery.",
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
