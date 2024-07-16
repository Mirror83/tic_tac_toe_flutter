import 'package:flutter/material.dart';
import 'package:tic_tac_toe/board.dart';
import 'package:tic_tac_toe/game.dart';
import "package:tic_tac_toe/components/pseudo_logo.dart";

class ModeSelection extends StatefulWidget {
  const ModeSelection({super.key});

  @override
  State<ModeSelection> createState() => _ModeSelectionState();
}

class _ModeSelectionState extends State<ModeSelection> {
  var playerOneMark = BoardToken.x;

  void changeMark(BoardToken mark) {
    setState(() {
      playerOneMark = mark;
    });
  }

  void _startNewGame(BuildContext context, GameMode gameMode) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TicTacToeGame(
          gameMode: gameMode,
          playerOneMark: playerOneMark,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Column(
                children: [
                  const PseudoLogo(),
                  const SizedBox(
                    height: 16,
                  ),
                  MarkPicker(
                    changeMark: changeMark,
                    selectedMark: playerOneMark,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  NewGameButtons(
                    startNewGame: _startNewGame,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NewGameButtons extends StatelessWidget {
  const NewGameButtons({
    super.key,
    required this.startNewGame,
  });

  final void Function(BuildContext, GameMode) startNewGame;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OutlinedButton(
          onPressed: () {
            startNewGame(context, GameMode.playerVsComputer);
          },
          child: const Text("NEW GAME (VS CPU)"),
        ),
        OutlinedButton(
          onPressed: () {
            startNewGame(context, GameMode.playerVsPlayer);
          },
          child: const Text("NEW GAME (VS PLAYER)"),
        ),
      ],
    );
  }
}

class MarkPicker extends StatelessWidget {
  final BoardToken selectedMark;
  final void Function(BoardToken) changeMark;
  const MarkPicker(
      {super.key, required this.changeMark, required this.selectedMark});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainer,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        border: BorderDirectional(
            bottom: BorderSide(width: 10, color: theme.colorScheme.shadow)),
      ),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Text("PICK PLAYER 1'S MARK"),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              color: theme.colorScheme.surface,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Mark(
                  changeMark: changeMark,
                  selectedMark: selectedMark,
                  mark: BoardToken.x,
                ),
                Mark(
                  changeMark: changeMark,
                  selectedMark: selectedMark,
                  mark: BoardToken.o,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              "REMEMBER, X GOES FIRST",
              style: theme.textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}

class Mark extends StatelessWidget {
  const Mark({
    super.key,
    required this.selectedMark,
    required this.mark,
    required this.changeMark,
  });

  final BoardToken selectedMark;
  final BoardToken mark;
  final void Function(BoardToken) changeMark;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        changeMark(mark);
      },
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 48),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            color: selectedMark == mark ? theme.colorScheme.tertiary : null,
          ),
          child: Text(
            mark == BoardToken.x ? "X" : "O",
            style: theme.textTheme.displaySmall!.copyWith(
                color:
                    selectedMark == mark ? theme.colorScheme.onTertiary : null,
                fontWeight: FontWeight.bold),
          )),
    );
  }
}
