import 'package:flutter/material.dart';
import 'package:salad_scorer/final_score_page.dart';
import 'package:salad_scorer/game_manager.dart';
import 'package:salad_scorer/scoring_exceptions.dart';

class RoundScoringPage extends StatefulWidget {
  final int roundNum;

  const RoundScoringPage({Key? key, required this.roundNum}) : super(key: key);

  @override
  State<RoundScoringPage> createState() => _RoundScoringPageState();
}

class _RoundScoringPageState extends State<RoundScoringPage> {

  final List<TextEditingController> _controllers = []; // This list allows reading of player names
  // int _roundNum = 3;
   late final String _roundDescription;
   late final String _scoringHelpDescription;
  // String _scoringHelpDescription = "For this round, every King of Spades is worth 100 points."
  //     "None of the other cards matter.\n\nFor example, if you end the round with the King of Spades "
  //     "you will get 100 points.";

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
              GameManager.acceptScores(widget.roundNum, _controllers);

              // Go to the next round
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RoundScoringPage(
                      roundNum: widget.roundNum + 1
                  ))
              );
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
    _roundDescription = GameManager.getRoundDescription(widget.roundNum);
    _scoringHelpDescription = GameManager.getScoringDescription(widget.roundNum);
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
              "Round ${widget.roundNum}:",
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
                                bool correctScores = GameManager.validateScores(widget.roundNum, _controllers);

                                if (correctScores) {
                                  // the scores are good, accept them and then go to the next round
                                  GameManager.acceptScores(widget.roundNum, _controllers);
                                  if (widget.roundNum < 7) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => RoundScoringPage(
                                      roundNum: widget.roundNum + 1
                                    ))
                                  );
                                  } else {
                                    // Calculate final scores and go to the scoring page
                                    GameManager.calculateWinner();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => const FinalScoringPage())
                                    );
                                  }
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
                                scrollable: true,
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
                  height: 75,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    border: Border.all(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 60,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: FittedBox(
                            fit: BoxFit.fill,
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
                            border: Border.all(color: Colors.black, width: 1.5),
                            color: Colors.white,
                          ),
                          child: Container(
                            margin: const EdgeInsets.only(left: 5),
                            child: TextField(
                              controller: _controllers[index],
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                hintText: "0 points",
                              ),
                              style: const TextStyle(fontSize: 22.5),
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
