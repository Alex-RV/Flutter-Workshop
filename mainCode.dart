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

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

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
        print("Changing ${game.board[index]}");
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
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 5, 2, 77),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TurnDisplay(
            lastValue: lastValue,
            gameOver: gameOver,
          ),
          GameBoard(
            gameOver: gameOver,
            onTap: onTap,
            game: game,
          ),
          ResultDisplay(
              lastValue: lastValue, result: result, isWinner: isWinner),
          RefreshButton(
            resetGame: resetGame,
            gameOver: gameOver,
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
          final boardValue = game.board[index];
          final isPlayable = !gameOver && boardValue.isEmpty;
          return InkWell(
            onTap: isPlayable ? () => onTap(index) : null,
            child: Container(
              width: 100,
              height: 100,
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

class TurnDisplay extends StatelessWidget {
  const TurnDisplay({required this.lastValue, required this.gameOver});

  final String lastValue;
  final bool gameOver;

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: !gameOver,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "It's ",
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
        ));
  }
}

class ResultDisplay extends StatelessWidget {
  const ResultDisplay(
      {required this.lastValue, required this.result, required this.isWinner});

  final String lastValue;
  final String result;
  final bool isWinner;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Visibility(
          // ADDED THIS
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
          result,
          style: TextStyle(color: Colors.white, fontSize: 50.0),
        ),
      ],
    );
  }
}

class RefreshButton extends StatelessWidget {
  const RefreshButton({
    required this.resetGame,
    required this.gameOver,
  });

  final Function resetGame;
  final bool gameOver;

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: gameOver,
        child: ElevatedButton.icon(
          onPressed: () => resetGame(),
          icon: Icon(Icons.replay),
          label: Text("Repeat game"),
        ));
  }
}
