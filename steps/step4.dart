import 'package:flutter/material.dart';
import 'package:tictactoe/game_logic.dart';

void main() => runApp(TicTacToe());

class TicTacToe extends StatelessWidget {
  const TicTacToe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      home: GameScreen(),
    );
  }
}

class GameScreen extends StatelessWidget {
  String lastValue = "X";
  bool gameOver = false;
  int turn = 0; // to check the draw
  String result = "";
  bool isWinner = false;

  Game game = Game();

  void onTap(int index) {
    if (game.board[index] == "") {
      game.board[index] = lastValue;
      turn++;
      gameOver = game.winnerCheck(lastValue, index);

      if (gameOver) {
        result = " is the Winner";
        isWinner = true;
      } else if (!gameOver && turn == 9) {
        result = "It's a Draw!";
        gameOver = true;
      }
      if (lastValue == "X") {
        lastValue = "O";
      } else {
        lastValue = "X";
      }
    }
  }

  void resetGame() {
    game.resetBoard();
    lastValue = "X";
    gameOver = false;
    turn = 0;
    result = "";
    isWinner = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 5, 2, 77),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GameBoard(
            gameOver: gameOver,
            onTap: onTap,
          ),
        ],
      ),
    );
  }
}

class GameBoard extends StatelessWidget {
  const GameBoard({
    required this.gameOver,
    required this.onTap,
  });

  final bool gameOver;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    double boardWidth = MediaQuery.of(context).size.shortestSide * 0.9;
    return SizedBox(
      width: boardWidth,
      height: boardWidth,
      child: GridView.count(
        crossAxisCount: 3,
        padding: EdgeInsets.all(16.0),
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
        children: List.generate(9, (index) {
          return Text(
            "Hello World",
            style: TextStyle(color: Colors.white),
          );
        }),
      ),
    );
  }
}
