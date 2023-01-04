import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TrickTakingInstructionPage extends StatefulWidget {
  const TrickTakingInstructionPage({Key? key}) : super(key: key);

  @override
  State<TrickTakingInstructionPage> createState() => _TrickTakingInstructionPageState();
}

class _TrickTakingInstructionPageState extends State<TrickTakingInstructionPage> {
  TextStyle fontStyle = TextStyle(fontSize: 30, color: Colors.white);

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
              "Trick-Taking Games",
             style: TextStyle(
               fontFamily: "Rubik",
               color: Colors.black,
                fontSize: 25,
              )
          )
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: RichText(
            text: TextSpan(
              text:
              "    In a trick taking game, all the cards are going to be shuffled and then dealt out so that"
              " each player has an equal number of cards. Then, the player to the left of the dealer"
              " chooses a card from their hand to play, putting it in the middle of the table.\n"
              "     Every other  player, going clockwise from the first player, must play a card from their hand."
              " The card they play ",
                //style: TextStyle(color: Colors.black, fontSize: 30),
                style: fontStyle,
              children: const <TextSpan>[
                TextSpan(
                    text: "must",
                    style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic)),
                TextSpan(
                  text:
                  " be of the same suit as the first card, unless the player does not have that suit."
                  " In that case the player can play any card. After everyone has played one card, the highest "
                  " card in the suit that was led takes all the cards in the middle, which is called the trick.\n"
                  "     The player will then put these cards face down in a stack in front of them. The player who took"
                  " The previous trick then gets to play the first card to start the next trick. Play continues"
                  " in this manner until all cards have been played.\n    It is important to note that when a player"
                  " gains a trick, these cards should be kept separate from the cards in their hand, and also separated"
                  " by trick. This makes it easy to calculate how many tricks the player got at the end of the round"
                  " for scoring purposes.",
                )
              ]
            )
          )
        )
      ),
    );
  }
}