import 'package:flutter/material.dart';
import 'package:tictactoe/game_logic.dart';
import 'package:auto_size_text/auto_size_text.dart';

void main() => runApp(TicTacToe());

class TicTacToe extends StatelessWidget {
  const TicTacToe({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      home: GameScreen(),
    );
  }
}

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

// ##TODO: add line when player winning the game

class _GameScreenState extends State<GameScreen> {
  String lastValue = "X";
  bool gameOver = false;
  int turn = 0; // to check the draw
  String result = "";
  bool isWinner = false;

  Game game = Game();

  void onTap(int index) {
    if (game.board[index] == "") {
      setState(() {
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
      });
    }
  }

  void resetGame() {
    setState(() {
      game.resetBoard();
      lastValue = "X";
      gameOver = false;
      turn = 0;
      result = "";
      isWinner = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    //tell about difference between double and int
    // double boardWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 5, 2, 77),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TurnDisplay(lastValue: lastValue),
          GameBoard(
            game: game,
            gameOver: gameOver,
            onTap: onTap,
          ),
          ResultDisplay(
            gameOver: gameOver,
            lastValue: lastValue,
            result: result,
            turn: turn,
            isWinner: isWinner,
          ),
          RefreshButton(
            resetGame: resetGame,
          ),
        ],
      ),
    );
  }
}

class ResultDisplay extends StatelessWidget {
  const ResultDisplay(
      {required this.lastValue,
      required this.gameOver,
      required this.result,
      required this.turn,
      required this.isWinner});

  final String lastValue;
  final bool gameOver;
  final String result;
  final int turn;
  final bool isWinner;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Visibility(
          visible: isWinner,
          child: SizedBox(
            width: 50,
            height: 50,
            child: lastValue == "O"
                ? Image.asset('assets/images/cross.png')
                : Image.asset('assets/images/circle.png'),
          ),
        ),
        Text(
          (turn == 9)
              ? result
              : gameOver
                  ? result
                  : "",
          style: TextStyle(color: Colors.white, fontSize: 50.0),
        ),
      ],
    );
  }
}

class TurnDisplay extends StatelessWidget {
  const TurnDisplay({required this.lastValue});

  final String lastValue;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "It's ".toUpperCase(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 58,
          ),
        ),
        SizedBox(
          width: 100,
          height: 100,
          child: lastValue == "X"
              ? Image.asset('assets/images/cross.png')
              : Image.asset('assets/images/circle.png'),
        ),
        Text(
          " turn",
          style: TextStyle(
            color: Colors.white,
            fontSize: 58,
          ),
        ),
      ],
    );
  }
}

class GameBoard extends StatelessWidget {
  const GameBoard({
    required this.game,
    required this.gameOver,
    required this.onTap,
  });

  final Game game;
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
        children: List.generate(Game.boardLength, (index) {
          final boardValue = game.board[index];
          final isPlayable = !gameOver && boardValue.isEmpty;
          return InkWell(
            onTap: isPlayable ? () => onTap(index) : null,
            child: Container(
              width: Game.blockSize,
              height: Game.blockSize,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 1, 37, 169),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: boardValue.isEmpty
                    ? Text('')
                    : game.board[index] == "X"
                        ? Image.asset('assets/images/cross.png')
                        : Image.asset('assets/images/circle.png'),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class RefreshButton extends StatelessWidget {
  const RefreshButton({required this.resetGame,});

  final Function resetGame;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => resetGame(),
      icon: Icon(Icons.replay),
      label: Text("Repeat game"),
    );
  }
}
