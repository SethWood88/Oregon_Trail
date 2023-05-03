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
            const SizedBox(height: 50),
            Text(
              "Instructions",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.green[900],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hey Beautiful, Yes I made this app from scratch like fresh dough. This should work perfectly...Maybe but we will see.",
                        style: TextStyle(
                          fontSize: 22,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "1. Start: Start your journey and travel across the desert to Oregon Trail",
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "2. Tragedies: This is the Oregon trail after all, bad things may happen. These are called Tragedies. These will randomly happen at random times to one of us randomly. This will go on throughout the whole journey. (You must do what they say.)",
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "3. Boredom Events: Sometimes life gets boring at times and you need things to do.",
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "4. Timing: Keeping a tight schedule will be important for this to work but dont worry there is plenty of downtime throughout.",
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "5. Remember to just have fun and listen and follow your guide (Seth) if you want to come out of this alive. ",
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(height: 50),
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
