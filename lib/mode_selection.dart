import 'package:flutter/material.dart';
import 'package:tic_tac_toe/game.dart';

class ModeSelection extends StatelessWidget {
  const ModeSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          children: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const TicTacToeGame(
                            gameMode: GameMode.playerVsComputer,
                          )));
                },
                child: const Text("You vs Computer")),
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const TicTacToeGame(
                            gameMode: GameMode.playerVsPlayer,
                          )));
                },
                child: const Text("You vs Human")),
          ],
        ),
      ),
    );
  }
}
