import 'package:flutter/material.dart';
import 'package:salad_scorer/game_manager.dart';
import 'package:salad_scorer/scoring_exceptions.dart';
import 'package:salad_scorer/round_scoring_page.dart';

class RoundThreeScoringPage extends StatefulWidget {
  const RoundThreeScoringPage({Key? key}) : super(key: key);

  @override
  State<RoundThreeScoringPage> createState() => _RoundThreeScoringPageState();
}

class _RoundThreeScoringPageState extends State<RoundThreeScoringPage> {
  final List<TextEditingController> _controllers = []; // This list allows reading of player names
  final int _roundNum = 3;
  final String _roundDescription = "The King of Spades is worth 100 points";
  final String _scoringHelpDescription = "For this round, every King of Spades is worth 100 points."
      "None of the other cards matter.\n\nFor example, if you end the round with the King of Spades "
      "you will get 100 points.";

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
              GameManager.acceptScores(_roundNum, _controllers);
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
          children: [
             Text(
              "Round $_roundNum:",
              style: const TextStyle(
                fontSize: 35,
                fontFamily: "Rubik",
                color: Colors.black
              ),
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                  _roundDescription,
                  style: const TextStyle(
                    fontFamily: "Rubik",
                    fontSize: 22.5, // Maximum/ideal size
                    color: Colors.black
                  )
              ),
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
                  return Row(
                    children: [
                      Expanded(
                        flex: 80,
                        child: SizedBox(
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
                                bool correctScores = GameManager.validateScores(_roundNum, _controllers);

                                if (correctScores) {
                                  // the scores are good, accept them and then go to the next round
                                  GameManager.acceptScores(_roundNum, _controllers);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const RoundScoringPage(
                                      roundNum: 4,
                                    ))
                                  );
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
                        ),
                      ),
                      Expanded(
                        flex: 20,
                        child: IconButton(
                          icon: const Icon(Icons.help),
                          iconSize: 45,
                          color: const Color.fromARGB(255, 77, 77, 255),
                          tooltip: "Help",
                          onPressed: () {
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text(
                                  "Scoring Help",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontFamily: "Rubik",
                                  )
                                ),
                                content: Text(
                                  _scoringHelpDescription,
                                  style: const TextStyle(
                                    fontSize: 25,
                                  )
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () => Navigator.pop(context, "OK"),
                                    child: const Text(
                                      "OK",
                                      style: TextStyle(fontSize: 20)
                                    ),
                                  )
                                ],
                              )
                            );
                          }
                        ),
                      )
                    ],
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
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerRight,
                            child: Text(
                                "${GameManager.getPlayerName(index)}'s score:",
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                  fontSize: 22.5,
                                )
                            ),
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
