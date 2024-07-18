import 'package:flutter/material.dart';
import 'package:tic_tac_toe/board.dart';
import 'package:tic_tac_toe/components/pseudo_logo.dart';

class Header extends StatelessWidget {
  final GameState gameState;
  final void Function() refreshBoardCallBack;
  const Header(
      {super.key, required this.gameState, required this.refreshBoardCallBack});

  BoardToken determineCurrentPlayer() {
    switch (gameState) {
      case GameState.playerOneTurn:
        return BoardToken.x;
      case GameState.playerTwoTurn:
        return BoardToken.o;
      default:
        return BoardToken.empty;
    }
  }

  void goBackHome(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                goBackHome(context);
              },
              child: const PseudoLogo(),
            ),
          ),
          TurnIndicator(currentPlayer: determineCurrentPlayer()),
          RefreshButton(refreshBoardCallBack: refreshBoardCallBack),
        ],
      ),
    );
  }
}

class TurnIndicator extends StatelessWidget {
  const TurnIndicator({
    super.key,
    required this.currentPlayer,
  });

  final BoardToken currentPlayer;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 100,
      padding: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainer,
        border: BorderDirectional(
          bottom: BorderSide(
            color: theme.colorScheme.shadow,
            width: 4,
          ),
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Text(
                currentPlayer == BoardToken.x
                    ? "X"
                    : currentPlayer == BoardToken.o
                        ? "O"
                        : "-",
                style: theme.textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                "TURN",
                style: theme.textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class RefreshButton extends StatelessWidget {
  const RefreshButton({
    super.key,
    required this.refreshBoardCallBack,
  });

  final void Function() refreshBoardCallBack;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: refreshBoardCallBack,
      icon: const Icon(Icons.refresh),
    );
  }
}
