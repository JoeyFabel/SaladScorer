import 'package:flutter/material.dart';
import 'package:salad_scorer/game_manager.dart';
import 'package:salad_scorer/setup_page.dart';

class PlayerSelectionPage extends StatefulWidget {
  const PlayerSelectionPage({Key? key}) : super(key: key);

  @override
  State<PlayerSelectionPage> createState() => _PlayerSelectionPageState();
}

class _PlayerSelectionPageState extends State<PlayerSelectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "How many players?",
          style: TextStyle(
            fontSize: 35,
            color: Colors.black,
            fontFamily: "Rubik",
          )
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 3; i <= 10; i++) Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                width: double.infinity,
                child: ElevatedButton(
                  child: Text(
                      "$i players",
                      style: const TextStyle(
                        fontSize: 30,
                        color: Colors.black
                      )
                  ),
                  onPressed: () {
                    // Initialize and create the GameManager singleton
                    GameManager.initializeGame(i);

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SetupInstructionPage())
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


/*
Expanded(
            child: Container(
              margin: const EdgeInsets.all(20),
              child: ElevatedButton(
                child: Text("4"),
                onPressed: () {
                  print("4 player game");
                },
              ),
            ),
          ),
 */