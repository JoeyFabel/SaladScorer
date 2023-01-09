import 'package:flutter/material.dart';
import 'package:salad_scorer/player_selection_page.dart';

import 'how_to_play.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Salad Scorer',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'Salad Scorer'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Container(
      // Create a background image
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/Salad.jpg'),
          fit: BoxFit.cover,
        )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent, // Enables the background image to be seen
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            widget.title,
            style: const TextStyle(
              color: Colors.black,
              fontFamily: "Rubik",
              fontSize: 40
            ),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 50, bottom: 20),
                width: 250,
                height: 100,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const PlayerSelectionPage())
                    );
                  },
                  child: const Text(
                    "New Game",
                    style: TextStyle(
                      fontSize: 40,
                      fontFamily: "Rubik",
                      color: Colors.black,
                    ),
                  )
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, bottom: 50),
                width: 250,
                height: 100,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HowToPlayPage())
                    );
                  },
                  child: const Text(
                    "How to Play",
                    style: TextStyle(
                      fontSize: 35,
                      fontFamily: "Rubik",
                      color: Colors.black,
                    ),
                  )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
