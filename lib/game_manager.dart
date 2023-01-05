import 'package:flutter/cupertino.dart';
import 'package:salad_scorer/scoring_exceptions.dart';

class GameManager {
  static late GameManager _instance;

  // Key corresponds to the number of players, value corresponds to correct score
  static const Map round1CorrectScores = {
    3: 170,
    4: 130,
    5: 100,
    6: 80,
    7: 140,
    8: 130,
    9: 110,
    10: 100
  };

  // Same as previous map, but this time for the seventh round
  static const Map round7CorrectScores = {
    3: 600,
    4: 560,
    5: 530,
    6: 510,
    7: 1000,
    8: 990,
    9: 970,
    10: 960
  };

  int _numPlayers = 0;

  List<String> _playerNames = <String>[];
  List<int> _playerScores = <int>[];

  // Initialize the GameManager by creating the singleton and setting the number of players
  static void initializeGame(int numPlayers)
  {
    // Create the instance if it is null, otherwise ignore this part
    _instance = GameManager();

    // Set the number of players in the game
    _instance._numPlayers = numPlayers;
  }

  // Getter for _numPlayers
  static int getNumPlayers() => _instance._numPlayers;

  // Two decks should be used if there are 7 or more players
  // This is a convenient way to access this value without calculating it outside the GameManager
  static bool useTwoDecks() => _instance._numPlayers >= 7;

  // Sets the player names from the given list
  static void submitPlayerNames(List<String> names) => _instance._playerNames = names;

  // Get the name of the player at the specified index of the names array
  static String getPlayerName(int index)
  {
    // Returns the player name if it exists, otherwise it returns an empty string
    if (index < _instance._playerNames.length) {
          return _instance._playerNames[index];
      }
    else {
      return "";
    }
  }

  static bool validateScores(int roundNumber, List<TextEditingController> controllers)
  {
    List<int> scores = [];
    // First extract the scores from the controllers
    for (var controller in controllers) {
      if (controller.text.isEmpty) {
        scores.add(0);
      } else {
        scores.add(int.parse(controller.text));
      }
    }

    // Test 1 - Do the scores add up to the correct number?
    int totalScores = 0;
    for (var score in scores) {
      totalScores += score;
    }

    // Switch determines if the correct total score was given based on the round number
    switch (roundNumber) {
      case 1: // 1 point per trick, with variable number of tricks depending on the number of players
        if (totalScores != round1CorrectScores[_instance._numPlayers]) {
          throw InvalidScoreSumException(totalScores, round1CorrectScores[_instance._numPlayers]);
        }
      break;
      case 2: // 10 points per heart, with 13 per deck
        if (totalScores != 130 * (useTwoDecks() ? 2 : 1)) {
          throw InvalidScoreSumException(totalScores, round1CorrectScores[_instance._numPlayers]);
        }
        break;
      case 3: // 100 per King of Spades, with 1 per deck
      case 4: // 25 per Queen, with 4 per deck
      case 5: // 100 per last trick, with two last tricks if two decks
        if (totalScores != 100 * (useTwoDecks() ? 2 : 1)) {
          throw InvalidScoreSumException(totalScores, round1CorrectScores[_instance._numPlayers]);
        }
        break;
      case 6: // 7-Up, 7-Down. Positive and Negative points cancel out for a total of zero
        if (totalScores != 0) {
          throw InvalidScoreSumException(totalScores, round1CorrectScores[_instance._numPlayers]);
        }
        break;
      case 7:
        if (totalScores != round7CorrectScores[_instance._numPlayers]) {
          throw InvalidScoreSumException(totalScores, round1CorrectScores[_instance._numPlayers]);
        }
        break;
    }

    // Next, check for negative numbers. There should be no negative numbers, except in round 6
    if (roundNumber != 6) {
      for (int i = 0; i < scores.length; i++) {
        if (scores[i] < 0) throw NegativeScoreException(i);
      }
    }

    // At this point the scores have the correct total. But there could still be errors!
    // Scores must be given in certain intervals - for example, in round 1 they must be in intervals of 10.
    // Determine that they were given in the correct format and not just randomly
    // This is harder for round 7, but they still follow a basic format of ending in either 5 or 0
    switch (roundNumber) {
      case 1: // Every score should be an interval of 10
      case 2:
        for (int i = 0; i < scores.length; i++) {
          if (scores[i] % 10 != 0) throw InvalidIndividualScoreException(i);
        }
        break;
      case 3: // Every score should be in an interval of 100
      case 5:
      case 6: // For this case, they could also be -100, but (-100) % 100 is still 0
        for (int i = 0; i < scores.length; i++) {
          if (scores[i] % 100 != 0) throw InvalidIndividualScoreException(i);
        }
        break;
      case 4: // Every score should be in an interval of 25
        for (int i = 0; i < scores.length; i++) {
          if (scores[i] % 25 != 0) throw InvalidIndividualScoreException(i);
        }
        break;
      case 7: // Scores will be added from 10s, 25s, and 100s, so they should evenly divide by 25 or 10
        for (int i = 0; i < scores.length; i++) {
          if (scores[i] % 25 != 0 && scores[i] % 10 != 0) throw InvalidIndividualScoreException(i);
        }
        break;
    }

    // The scores have passed all three tests, so they are valid!
    return true;
  }
}