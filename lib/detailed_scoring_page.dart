import 'package:flutter/material.dart';

import 'game_manager.dart';

class DetailedScoringPage extends StatefulWidget {
  const DetailedScoringPage({Key? key}) : super(key: key);

  @override
  State<DetailedScoringPage> createState() => _DetailedScoringPageState();
}

class _DetailedScoringPageState extends State<DetailedScoringPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Detailed Scores",
          style: TextStyle(
            fontSize: 35,
            fontFamily: "Rubik",
            color: Colors.black
          )
        )
      ),
      body: ListView.builder(
        itemCount: 7,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int roundIndex) {
          return Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.green[100 * (roundIndex + 2)]
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Round ${roundIndex + 1}:",
                  style: const TextStyle(
                    fontSize: 30,
                    fontFamily: "Rubik",
                    color: Colors.black,
                  ),
                ),
                for (int i = 0; i < GameManager.getNumPlayers(); i++) Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    "${GameManager.getPlayerName(i)}'s score: "
                    "${GameManager.getScore(i, roundIndex + 1)}",
                    style: const TextStyle(
                      fontSize: 25
                    ),
                  ),
                )
              ],
            ),
          );
        }
      ),
    );
  }
}
