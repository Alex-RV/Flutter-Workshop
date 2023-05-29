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
            game: game,
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
    required this.game,
  });

  final bool gameOver;
  final Function(int) onTap;
  final Game game;

  @override
  Widget build(BuildContext context) {
    double boardWidth = MediaQuery.of(context).size.shortestSide;
    return SizedBox(
      width: boardWidth,
      height: boardWidth,
      child: GridView.count(
        crossAxisCount: 3,
        padding: EdgeInsets.all(16.0),
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
        children: List.generate(9, (index) {
          // ADD THIS
          final boardValue = game.board[index];
          final isPlayable = !gameOver && boardValue.isEmpty;
          return InkWell(
            onTap: () => print("Hello $index"),
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 1, 37, 169),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text("Hello World"),
            ),
          );
        }),
      ),
    );
  }
}
