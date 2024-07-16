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
  var playerOneToken = BoardToken.x;

  void changePlayerOneToken(BoardToken token) {
    setState(() {
      playerOneToken = token;
    });
  }

  void _startNewGame(BuildContext context, GameMode gameMode) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TicTacToeGame(
          gameMode: gameMode,
          playerOneToken: playerOneToken,
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
                  TokenPicker(
                    changeToken: changePlayerOneToken,
                    selectedToken: playerOneToken,
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

class TokenPicker extends StatelessWidget {
  final BoardToken selectedToken;
  final void Function(BoardToken) changeToken;
  const TokenPicker(
      {super.key, required this.changeToken, required this.selectedToken});

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
            child: Text("PICK PLAYER 1'S TOKEN"),
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
                TokenWidget(
                  changeToken: changeToken,
                  selectedToken: selectedToken,
                  token: BoardToken.x,
                ),
                TokenWidget(
                  changeToken: changeToken,
                  selectedToken: selectedToken,
                  token: BoardToken.o,
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

class TokenWidget extends StatelessWidget {
  const TokenWidget({
    super.key,
    required this.selectedToken,
    required this.token,
    required this.changeToken,
  });

  final BoardToken selectedToken;
  final BoardToken token;
  final void Function(BoardToken) changeToken;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        changeToken(token);
      },
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 48),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            color: selectedToken == token ? theme.colorScheme.tertiary : null,
          ),
          child: Text(
            token == BoardToken.x ? "X" : "O",
            style: theme.textTheme.displaySmall!.copyWith(
                color: selectedToken == token
                    ? theme.colorScheme.onTertiary
                    : null,
                fontWeight: FontWeight.bold),
          )),
    );
  }
}
