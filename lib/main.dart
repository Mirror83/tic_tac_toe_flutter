import 'package:flutter/material.dart';
import 'package:tic_tac_toe/game.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF192A32),
          primary: const Color(0xFF2FC5BD),
          secondary: const Color(0xFFF2B237),
        ),
      ),
      home: const Scaffold(
        body: TicTacToeGame(),
      ),
    );
  }
}
