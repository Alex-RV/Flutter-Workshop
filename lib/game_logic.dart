class Player {
  static const x = "X";
  static const o = "O";
  static const empty = "";
}

class Game {

  //Empty board
  late List<String> board;

  Game() {
    board = initGameBoard();
  }

  void resetBoard() {
    board = initGameBoard();
  }

  static List<String> initGameBoard() =>
      List.generate(9, (index) => Player.empty);

  bool winnerCheck(String player, int index) {
    // Define the winning patterns
    final patterns = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8], // Rows
      [0, 3, 6], [1, 4, 7], [2, 5, 8], // Columns
      [0, 4, 8], [2, 4, 6] // Diagonals
    ];

    // Check if any of the winning patterns is satisfied by the player's moves
    for (final pattern in patterns) {
      if (pattern.every((index) => board[index] == player)) {
        return true;
      }
    }

    return false;
  }
}
