import 'package:flutter/material.dart';


void main() => runApp(TicTacToe());


class TicTacToe extends StatelessWidget {
 const TicTacToe({super.key});


 @override
 Widget build(BuildContext context) {
   return MaterialApp(
     title: 'Tic Tac Toe',
     home: Text("Hello World"),
   );
 }
}
