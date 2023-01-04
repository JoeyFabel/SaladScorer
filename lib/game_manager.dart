class GameManager {
  static late GameManager _instance;

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

    print("Playing a game with $numPlayers players");
  }

  // Getter for _numPlayers
  static int getNumPlayers() => _instance._numPlayers;

  // Two decks should be used if there are 7 or more players
  // This is a convenient way to access this value without calculating it outside the GameManager
  static bool useTwoDecks() => _instance._numPlayers >= 7;
}