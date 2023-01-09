import 'package:flutter/material.dart';
import 'package:salad_scorer/game_manager.dart';

import 'main.dart';

class FinalScoringPage extends StatefulWidget {
  const FinalScoringPage({Key? key}) : super(key: key);

  @override
  State<FinalScoringPage> createState() => _FinalScoringPageState();
}

class _FinalScoringPageState extends State<FinalScoringPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Results:",
          style: TextStyle(
            fontSize: 35,
            fontFamily: "Rubik",
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: ListView.builder(
          itemCount: GameManager.getNumPlayers() + 1,
          itemBuilder: (BuildContext context, int index) {
            if (index == GameManager.getNumPlayers()) {
              return SizedBox(
                height: 60,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(45),
                      )
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(255, 4, 98, 7)
                    )
                  ),
                  child: const Text(
                    "Back to Menu",
                    style: TextStyle(
                      fontSize: 30,
                      fontFamily: "Rubik",
                      color: Colors.black,
                    )
                  ),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const MyHomePage(title: "Salad Scorer")),
                        (route) => false
                    );
                  }
                ),
              );
            } else {
              return Container(
                  decoration: BoxDecoration(
                    color: GameManager.isPlayerWinner(index)
                        ? Colors.yellow
                        : Colors.green,
                    border: Border.all(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  margin: const EdgeInsets.only(bottom: 20),
                  child: SizedBox(
                    height: 50,
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            "${GameManager.getPlayerName(
                                index)}'s score: ${GameManager.getFinalScore(
                                index)}",
                            style: TextStyle(
                              fontSize: 22.5,
                              color: Colors.black,
                              fontWeight: GameManager.isPlayerWinner(index)
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            )
                        ),
                      ),
                    ),
                  )
              );
            }
          }
        ),
      )
    );
  }
}
