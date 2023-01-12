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

  static const Map roundDescriptions = {
    1: "Every trick is worth 10 points",
    2: "Every Heart is worth 10 points",
    3: "The King of Spades is worth 100 points",
    4: "Every Queen is worth 25 points",
    51: "The last trick is worth 100 points",
    52: "The last two tricks are worth 100 points",
    61: "7-Up, 7-Down (First/Last player out)",
    62: "7-Up, 7-Down (First two/Last two players out)",
    71: "The Apocalypse (Scoring of Rounds 1-5)",
    72: "The Apocalypse (Scoring of Rounds 1-5)",
  };

  static const Map scoringHelpDescriptions = {
    1: "For this round, every trick you take is worth 10 points."
          "The cards in the trick do not matter.\n\n"
          "For example, if you take 3 tricks you will get 30 points.",
    2: "For this round, every heart card is worth 10 points. "
        "It does not matter what number is on the card.\n\n"
        "For example, if you take 6 heart cards you will get 60 points.",
    3: "For this round, every King of Spades is worth 100 points."
        "None of the other cards matter.\n\nFor example, if you end the round with the King of Spades "
        "you will get 100 points.",
    4: "For this round, every Queen is worth 25 points. The suit of the Queen does not matter.\n\n"
        "For example, if you end the round with 3 Queens you will get 75 points",
    51: "For this round, the last trick is worth 100 points. None of the other tricks matter.\n\n"
        "For example, if you get the last trick of the round you will get 100 points.",
    52: "For this round, the last two tricks are worth 100 points each."
          "None of the other tricks matter.\n\n"
          "For example, if you take the last two tricks of the round you will get 200 points.",
    61: "This round you are playing the game 7-Up, 7-Down.\n"
        "On your turn you can play one card from your hand. If there is nothing on the table, "
        "you can only play a 7. If there are cards on the table you can play a card of the same suit "
        "that is either directly above or below that card numerically. If you can't you must pass.\n"
        "For example, if there is a 7 of Hearts on the table you can play a 6 of Hearts, an 8 of Hearts, "
        "or another 7 of any suit.\nAces are played above Kings.\n\n"
        "The first person to run out of cards loses 100 points, and the last person to run out of cards "
        "gains 100 points.",
    62: "This round you are playing the game 7-Up, 7-Down.\n"
        "On your turn you can play one card from your hand. If there is nothing on the table, "
        "you can only play a 7. If there are cards on the table you can play a card of the same suit "
        "that is either directly above or below that card numerically. If you can't you must pass\n"
        "For example, if there is a 7 of Hearts on the table you can play a 6 of Hearts, an 8 of Hearts, "
        "or another 7 of any suit.\nAces are played above Kings.\n\n"
        "The first two people to run out of cards lose 100 points, and the last two people "
        "to run out of cards gain 100 points.",
    71: "This round is the Apocalypse. The scoring methods of the first five rounds all apply.\n"
         "- Every trick is worth 10 points.\n"
         "- Every Heart is worth 10 points.\n"
         "- The King of Spades is worth 100 points.\n"
         "- Every Queen is worth 25 points.\n"
         "- The last trick is worth 100 points.",
    72: "This round is the Apocalypse. The scoring methods of the first five rounds all apply.\n"
        "- Every trick is worth 10 points.\n"
        "- Every Heart is worth 10 points.\n"
        "- Both King of Spades is worth 100 points.\n"
        "- Every Queen is worth 25 points.\n"
        "- The last two tricks are worth 100 points."
};

  int _numPlayers = 0;
  final List<int> _winningPlayers = [];

  List<String> _playerNames = <String>[];
  late List<List<int>> _playerScores;

  // Initialize the GameManager by creating the singleton and setting the number of players
  static void initializeGame(int numPlayers)
  {
    // Create the instance if it is null, otherwise ignore this part
    _instance = GameManager();

    // Set the number of players in the game
    _instance._numPlayers = numPlayers;

    // Initialize the list of player scores with one list per player, each list with 7 entries
    _instance._playerScores = List.generate(numPlayers, (i) => List.generate(7, (i) => 0));
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
          throw InvalidScoreSumException(totalScores, 130 * (useTwoDecks() ? 2 : 1));
        }
        break;
      case 3: // 100 per King of Spades, with 1 per deck
      case 4: // 25 per Queen, with 4 per deck
      case 5: // 100 per last trick, with two last tricks if two decks
        if (totalScores != 100 * (useTwoDecks() ? 2 : 1)) {
          throw InvalidScoreSumException(totalScores, 100 * (useTwoDecks() ? 2 : 1));
        }
        break;
      case 6: // 7-Up, 7-Down. Positive and Negative points cancel out for a total of zero
        if (totalScores != 0) {
          throw InvalidScoreSumException(totalScores, 0);
        }
        break;
      case 7:
        if (totalScores != round7CorrectScores[_instance._numPlayers]) {
          throw InvalidScoreSumException(totalScores, round7CorrectScores[_instance._numPlayers]);
        }
        break;
    }

    // Next, check for negative numbers. There should be no negative numbers, except in round 6
    if (roundNumber != 6) {
      for (int i = 0; i < scores.length; i++) {
        if (scores[i] < 0) throw NegativeScoreException(i);
      }
    } else {
      // It is round 6, make sure there is 1 negative score per deck
      int numNegatives = 0;
      int numPositives = 0;
      for (int i = 0; i < scores.length; i++) {
        if (scores[i] < 0) {
          numNegatives++;
        } else if (scores[i] > 0) {
          numPositives++;
        }

        if (numNegatives > (useTwoDecks() ? 2 : 1)) throw NegativeScoreException(i);
      }

      // Make sure there is the right number of negative scores
      if (numNegatives != (useTwoDecks() ? 2 : 1)) throw NotEnoughNegativesScoreException(useTwoDecks() ? 2: 1, numNegatives);
      if (numPositives != (useTwoDecks() ? 2 : 1)) throw NotEnoughPositiveScoreException(useTwoDecks() ? 2 : 1, numPositives);
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
      case 7: // Scores will be added from 10s, 25s, and 100s, so they should evenly divide by 5
        for (int i = 0; i < scores.length; i++) {
          if (scores[i] % 5 != 0) throw InvalidIndividualScoreException(i);
        }
        break;
    }

    // The scores have passed all three tests, so they are valid!
    return true;
  }

  static void acceptScores(int roundNumber, List<TextEditingController> controllers)
  {
    List<int> scores = [];
    // Extract the scores from the controllers
    for (var controller in controllers) {
      if (controller.text.isEmpty) {
        scores.add(0);
      } else {
        scores.add(int.parse(controller.text));
      }
    }

    for (int i = 0; i < scores.length; i++) {
      _instance._playerScores[i][roundNumber - 1] = scores[i];
    }
  }

  static void calculateWinner() {
    int lowestScore = 99999;

    for (int i = 0; i < _instance._numPlayers; i++) {
      int totalScore = getFinalScore(i);

      if (totalScore < lowestScore) {
        // There is a new lowest score, reset the winners and add just this player
        _instance._winningPlayers.clear();
        _instance._winningPlayers.add(i);
        lowestScore = totalScore;
      } else if (totalScore == lowestScore) {
        // There is another player with the same lowest score, add them to the winners list
        _instance._winningPlayers.add(i);
      }
    }
  }

  static bool isPlayerWinner(int playerIndex) {
    return _instance._winningPlayers.contains(playerIndex);
  }

  static int getFinalScore(int playerIndex) {
    int totalScore = 0;

    for (int score in _instance._playerScores[playerIndex]) {
      totalScore += score;
    }

    return totalScore;
  }

  static int getScore(int playerIndex, int roundNum) {
    return _instance._playerScores[playerIndex][roundNum - 1];
  }

  static String getRoundDescription(int roundNum)
  {
      if (roundNum <= 4) {
        return roundDescriptions[roundNum];
      } else {
        return roundDescriptions[roundNum * 10 + (useTwoDecks() ? 2 : 1)];
      }
  }

  static String getScoringDescription(int roundNum)
  {
    if (roundNum <= 4) {
      return scoringHelpDescriptions[roundNum];
    } else {
      return scoringHelpDescriptions[roundNum * 10 + (useTwoDecks() ? 2 : 1)];
    }
  }
}