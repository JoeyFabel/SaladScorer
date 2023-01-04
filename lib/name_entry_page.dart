import 'package:flutter/material.dart';
import 'package:salad_scorer/game_manager.dart';

class NameEntryPage extends StatefulWidget {
  const NameEntryPage({Key? key}) : super(key: key);

  @override
  State<NameEntryPage> createState() => _NameEntryPageState();
}

class _NameEntryPageState extends State<NameEntryPage> {
  final List<TextEditingController> _controllers = [];

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
        child: Column(
          children: [
            for (int i = 1; i <= GameManager.getNumPlayers(); i++ ) Container(
              //color: Colors.green,
              decoration: BoxDecoration(
                color: Colors.green,
                border: Border.all(color: Colors.black),
                borderRadius: const BorderRadius.all(Radius.circular(20.0))
              ),
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                children: [
                  Expanded(
                    flex: 60,
                    child: Text(
                      "Player $i's name: ",
                      style: const TextStyle(
                        fontSize: 22.5,
                      )
                    )
                  ),
                  Expanded(
                    flex: 40,
                    child: Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 10, right: 10),
                      decoration: BoxDecoration(
                       border: Border.all(color: Colors.black),
                       color: Colors.white,
                      ),
                      child: TextField(
                        controller: _controllers[i - 1],
                        textCapitalization: TextCapitalization.words,
                      ),
                    )
                  )
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}
