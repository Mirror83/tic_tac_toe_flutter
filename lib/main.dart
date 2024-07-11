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
      home: Scaffold(
          body: Column(
        children: [
          buildHeader(context),
          const TicTacToeGame(),
        ],
      )),
    );
  }

  Widget buildHeader(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final pseudoLogo = RichText(
        text: TextSpan(
            text: "X",
            style: TextStyle(
                color: theme.colorScheme.primary,
                fontSize: theme.textTheme.displayMedium!.fontSize),
            children: [
          TextSpan(
              text: "O",
              style: TextStyle(
                color: theme.colorScheme.secondary,
              ))
        ]));

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            pseudoLogo,
            const Text("X's turn"),
            const Text("Refresh")
          ],
        ),
      ),
    );
  }
}
