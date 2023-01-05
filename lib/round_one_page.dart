import 'package:flutter/material.dart';
import 'package:salad_scorer/game_manager.dart';
import 'package:salad_scorer/scoring_exceptions.dart';

class RoundOneScoringPage extends StatefulWidget {
  const RoundOneScoringPage({Key? key}) : super(key: key);

  @override
  State<RoundOneScoringPage> createState() => _RoundOneScoringPageState();
}

class _RoundOneScoringPageState extends State<RoundOneScoringPage> {
  final List<TextEditingController> _controllers = []; // This list allows reading of player names

  void showErrorDialog(String errorMessage)
  {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        title: const Text(
          "Oops!",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 30,
            fontFamily: "Rubik",
          ),
        ),
        content: Text(
          errorMessage,
          style: const TextStyle(
            fontSize: 25,
            // fontFamily: "Rubik",
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, "Cancel"),
            child: const Text(
              "Go back",
              style: TextStyle(fontSize: 20)
            ),
          ),
          TextButton(
            onPressed: () {
              // There were incorrect scores, but the user chose to ignore them and continue anyway
              // This can be useful if someone already got rid of their cards
              // or if its too much work to figure out where the problem lies
              // (although this app should alert the user who has incorrect scores)
              Navigator.pop(context, "OK");
              GameManager.acceptScores(1, _controllers);
              // TODO - Next round
            },
            child: const Text(
              "Continue anyway",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.red
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState()
  {
    super.initState();

    for (int i = 0; i < GameManager.getNumPlayers(); i++)
      {
        _controllers.add(TextEditingController());
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        toolbarHeight: 100.0,
        title: Column(
          children: const [
            Text(
              "Round 1:",
              style: TextStyle(
                fontSize: 35,
                fontFamily: "Rubik",
                color: Colors.black
              ),
            ),
            Text(
                "Every trick is worth 10 points",
                style: TextStyle(
                  fontSize: 22.5,
                  fontFamily: "Rubik",
                  color: Colors.black
                )
            )
          ],
        ),
      ),
      body: Container(
          margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
          child: ListView.builder(
            itemCount: GameManager.getNumPlayers() + 1,
            itemBuilder: (BuildContext context, int index) {
              if (index == GameManager.getNumPlayers()) {
                  return SizedBox(
                    height: 60,
                    child: ElevatedButton(
                        child: const Text(
                          "Continue",
                          style: TextStyle(
                            fontSize: 35,
                            fontFamily: "Rubik",
                            color: Colors.black,
                          )
                      ),
                      onPressed: () {
                        try {
                          bool correctScores = GameManager.validateScores(1, _controllers);

                          if (correctScores) {
                            // the scores are good, accept them and then go to the next round
                            GameManager.acceptScores(1, _controllers);
                            // TODO - Next round
                          }
                        } on InvalidScoreSumException catch (e) {
                          showErrorDialog(
                              "The scores should add to ${e.targetSum}, but they add to ${e.currentSum}."
                          );
                        } on NegativeScoreException catch (e) {
                          showErrorDialog(
                              "${GameManager.getPlayerName(e.offendingScoreIndex)}'s score should not be negative!"
                          );
                        } on InvalidIndividualScoreException catch (e) {
                          showErrorDialog(
                              "${GameManager.getPlayerName(e.offendingScoreIndex)}'s score is invalid!"
                          );
                        }
                      }
                    )
                  );
                }
              else {
                return Container(
                decoration: BoxDecoration(
                    color: Colors.green,
                    border: Border.all(color: Colors.black),
                    borderRadius: const BorderRadius.all(Radius.circular(20.0))
                ),
                margin: const EdgeInsets.only(bottom: 20),
                child: Row(
                  children: [
                    Expanded(
                        flex: 60,
                        child: Container(
                          margin: const EdgeInsets.only(left: 10, right: 10),
                          child: Text(
                              "${GameManager.getPlayerName(index)}'s score:",
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                // TODO - Change font size if player name too long
                                fontSize: 22.5,
                              )
                          ),
                        )
                    ),
                    Expanded(
                        flex: 40,
                        child: Container(
                          margin: const EdgeInsets.only(
                              top: 10, bottom: 10, right: 10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            color: Colors.white,
                          ),
                          child: Container(
                            margin: const EdgeInsets.only(left: 5),
                            child: TextField(
                              controller: _controllers[index],
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                hintText: "0 points"
                              )
                            ),
                          ),
                        )
                    )
                  ],
                ),
              );
              }
            }
          )
      ),
    );
  }
}
