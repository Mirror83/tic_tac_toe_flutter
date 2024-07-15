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
                  const NewGameButtons(),
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
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OutlinedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const TicTacToeGame(
                        gameMode: GameMode.playerVsComputer,
                      )));
            },
            child: const Text("NEW GAME (VS CPU)")),
        OutlinedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const TicTacToeGame(
                        gameMode: GameMode.playerVsPlayer,
                      )));
            },
            child: const Text("NEW GAME (VS PLAYER)")),
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
        color: theme.colorScheme.tertiaryFixedDim,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Text("PICK PLAYER 1's MARK"),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              color: theme.colorScheme.surfaceDim,
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
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Text("REMEMBER, X GOES FIRST"),
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
            color: selectedMark == mark ? theme.colorScheme.surface : null,
          ),
          child: Text(
            mark == BoardToken.x ? "X" : "O",
            style: theme.textTheme.displaySmall!.copyWith(
                color: selectedMark == mark ? theme.colorScheme.primary : null,
                fontWeight: FontWeight.bold),
          )),
    );
  }
}
