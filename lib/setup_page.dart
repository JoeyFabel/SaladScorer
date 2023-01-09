import 'package:flutter/material.dart';
import 'package:salad_scorer/game_manager.dart';
import 'package:salad_scorer/name_entry_page.dart';

class SetupInstructionPage extends StatefulWidget {
  const SetupInstructionPage({Key? key}) : super(key: key);

  @override
  State<SetupInstructionPage> createState() => _SetupInstructionPageState();
}

class _SetupInstructionPageState extends State<SetupInstructionPage> {

  String _getInstructions()
  {
    switch (GameManager.getNumPlayers())
    {
      case 3:
        return "Use one deck and take out the 2 of Diamonds.";
      case 4:
        return "Use one deck and use all the cards.";
      case 5:
        return "Use one deck and take out the 2 of Diamonds and 2 of Clubs.";
      case 6:
        return "Use one deck and take out the 2 and 3 of Diamonds, the 2 of Clubs, and the 2 of Spades.";
      case 7:
        return "Use two decks and take out the 2s of Diamonds, the 2s of Clubs, and the 2s of Spades";
      case 8:
        return "Use two decks and use all the cards.";
      case 9:
        return "Use two decks and take out the 2s of Diamonds, the 2s of Clubs, and one 2 of Spades.";
      case 10:
      default:
        return "Use two decks and take out the 2s of Diamonds and the 2s of Clubs.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/Salad.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Color.fromARGB(75, 255, 255, 255),
        appBar: AppBar(
          title: Text(
            "Setup (${GameManager.getNumPlayers()} players)",
            style: const TextStyle(
              fontSize: 30,
              color: Colors.black,
              fontFamily: "Rubik",
            )
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            const Spacer(),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                  _getInstructions(),
                  style: const TextStyle(
                    fontSize: 35,
                  ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                    height: 100,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
                      child: const Text(
                        "Continue",
                        style: TextStyle(
                          fontSize: 50,
                          color: Colors.black,
                          fontFamily: "Rubik"
                        )
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const NameEntryPage())
                        );
                      }
                    ),
                  ),
                ),
              ],
            ),
            const Spacer()
          ],
        ),
      ),
    );
  }
}
