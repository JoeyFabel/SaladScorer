import 'package:flutter/material.dart';
import 'trick_taking_instructions.dart';
import 'package:flutter/gestures.dart';

class HowToPlayPage extends StatefulWidget {
  const HowToPlayPage({Key? key}) : super(key: key);

  @override
  State<HowToPlayPage> createState() => _HowToPlayPageState();
}

class _HowToPlayPageState extends State<HowToPlayPage> {
  final TextStyle fontStyle = const TextStyle(fontSize: 30, color: Colors.white);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Salad.jpg'),
            fit: BoxFit.cover,
          )
      ),
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(0.5),
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
              "How to Play:",
              style: TextStyle(
                fontSize: 40,
                fontFamily: "Rubik",
                color: Colors.black,
              ),
            ),
          ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
            padding: const EdgeInsets.only(left: 10, right: 10),
          child: RichText(
            text:  TextSpan(
              text: "Welcome to salad!\n",
              style: fontStyle,
            children: [
              TextSpan(
                  text: "his is a trick taking card game. If you don't know what that is, ",
                  style: fontStyle
              ),
              TextSpan(
                  text: "tap here.",
                  style: const TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const TrickTakingInstructionPage())
                    );
                  },
              ),
              TextSpan(
                text:
                  "\n\nIn Salad, there is a different way to get points every round."
                  " However, you do not want points; the player with the fewest points at the end of the game wins."
                  "\n\nYou will need one deck of cards for 3-6 players and two decks of cards for 7-10 players."
                  "\n\nThe game will consist of seven different rounds:\n",
                  style: fontStyle,
              ),

              TextSpan(text:
                    "- Round 1: Every trick is 10 points\n"
                    "- Round 2: Every heart is 10 points\n"
                    "- Round 3: Every King of Spades is 100 points\n"
                    "- Round 4: Every Queen is 25 points\n"
                    "- Round 5: The last trick/last two tricks are worth 100 points each\n"
                    "- Round 6: Seven-Up, Seven-Down. The first one/two people out lose 100 points, the last one/two people out get 100 points.\n"
                    "- Round 7: Score using the methods of Rounds 1-5.\n",
                style: TextStyle(
                  fontSize: (fontStyle.fontSize ?? 0) - 5,
                )
              ),
              TextSpan(
                text: "After all seven rounds, the player(s) with the lowest score win!",
                style: fontStyle,
              )
            ],
            )
          ),
        )
      ),
    );
  }
}

/*
recognizer: TapGestureRecognizer()..onTap = () => print("Tapped")),
 */