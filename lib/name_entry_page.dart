import 'package:flutter/material.dart';
import 'package:salad_scorer/game_manager.dart';
import 'package:salad_scorer/round_one_page.dart';

class NameEntryPage extends StatefulWidget {
  const NameEntryPage({Key? key}) : super(key: key);

  @override
  State<NameEntryPage> createState() => _NameEntryPageState();
}

class _NameEntryPageState extends State<NameEntryPage> {
  final List<TextEditingController> _controllers = [];
  final List<FocusNode> _focusNodes = [];

  @override
  void initState()
  {
    super.initState();
    for (int i = 0; i < GameManager.getNumPlayers(); i++)
    {
      _controllers.add(TextEditingController());
      _focusNodes.add(FocusNode());
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          "Enter Player Names",
          style: TextStyle(
            fontSize: 35,
            fontFamily: "Rubik",
            color: Colors.black
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: GameManager.getNumPlayers() + 1,
          itemBuilder: (BuildContext context, int index) {
            // Creates a button at the end of the list view
            if (index == GameManager.getNumPlayers())
              {
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
                      // Check if each player has a name
                      bool allNamesEntered = true;
                      for (int i = 0; i < GameManager.getNumPlayers(); i++)
                        {
                          if (_controllers[i].text.isEmpty)
                            {
                              allNamesEntered = false;
                              _focusNodes[i].requestFocus();
                              break;
                            }
                        }

                      if (allNamesEntered) {
                        // Enter all the names into one list
                        List<String> nameList = [];
                        for (var name in _controllers) {
                          nameList.add(name.text);
                        }
                        // And pass that list to the GameManager
                        GameManager.submitPlayerNames(nameList);

                        // Proceed to the first scoring page
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const RoundOneScoringPage())
                        );
                      }
                      else
                        {
                          print("not all names entered!");
                        }
                    }
                  ),
                );
              }
            else {
              // This is the container that holds the text and input field for each player
              return Container(
              //color: Colors.green,
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
                      child: Text(
                          "Player ${index + 1}'s name: ",
                          style: const TextStyle(
                            fontSize: 22.5,
                          )
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
                        child: TextField(
                          controller: _controllers[index],
                          focusNode: _focusNodes[index],
                          textCapitalization: TextCapitalization.words,
                        ),
                      )
                  )
                ],
              ),
            );
            }
          }
        ),

      )
    );
  }
}
