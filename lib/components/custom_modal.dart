import 'package:flutter/material.dart';
import 'package:tic_tac_toe/board.dart';
import 'package:tic_tac_toe/game.dart';

class CustomModal extends StatefulWidget {
  final void Function() dismiss;
  final void Function() onConfirm;
  final void Function() onCancel;
  final bool isVisible;

  final Widget promptWidget;
  final String confirmText;
  final String cancelText;

  const CustomModal({
    super.key,
    required this.isVisible,
    required this.dismiss,
    required this.onConfirm,
    required this.onCancel,
    required this.promptWidget,
    required this.confirmText,
    required this.cancelText,
  });

  @override
  State<CustomModal> createState() => _CustomModalState();
}

class _CustomModalState extends State<CustomModal>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> alphaAnimation;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300))
      ..addStatusListener((status) {
        setState(() {});
      });
    alphaAnimation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
  }

  @override
  void didUpdateWidget(covariant CustomModal oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!oldWidget.isVisible && widget.isVisible) {
      controller.forward();
    } else if (oldWidget.isVisible && !widget.isVisible) {
      controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.isVisible
          ? true
          : controller.status != AnimationStatus.dismissed,
      child: FadeTransition(
        opacity: alphaAnimation,
        child: Stack(
          children: [
            _CustomModalOverlay(dismiss: widget.dismiss),
            _CustomModalContent(
              onCancel: widget.onCancel,
              onConfirm: widget.onConfirm,
              promptWidget: widget.promptWidget,
              confirmText: widget.confirmText,
              cancelText: widget.cancelText,
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomModalOverlay extends StatelessWidget {
  const _CustomModalOverlay({
    required this.dismiss,
  });

  final void Function() dismiss;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: dismiss,
      child: Container(
        color: const Color.fromARGB(150, 0, 0, 0),
        child: const Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
            )
          ],
        ),
      ),
    );
  }
}

class _CustomModalContent extends StatelessWidget {
  const _CustomModalContent({
    required this.onCancel,
    required this.onConfirm,
    required this.promptWidget,
    required this.confirmText,
    required this.cancelText,
  });

  final Widget promptWidget;
  final String confirmText;
  final String cancelText;

  final void Function() onCancel;
  final void Function() onConfirm;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          color: theme.colorScheme.surfaceContainer,
          padding: const EdgeInsets.symmetric(vertical: 48),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  promptWidget,
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: theme.colorScheme.secondary,
                        ),
                        onPressed: onCancel,
                        child: Text(cancelText),
                      ),
                      const SizedBox(width: 16),
                      FilledButton(
                        onPressed: onConfirm,
                        child: Text(confirmText),
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class TerminalStatePrompt extends StatelessWidget {
  final GameMode gameMode;
  final GameState gameState;
  final BoardToken playerOneToken;

  static const winMsg = "YOU WIN!";
  static const loseMsg = "YOU LOSE";
  static const drawMsg = "It's a draw.";
  static const unexpectedGameStateErrMsg = "Unexpected game state!";

  const TerminalStatePrompt({
    super.key,
    required this.gameMode,
    required this.gameState,
    required this.playerOneToken,
  });

  String _determineHeaderText() {
    switch (gameMode) {
      case GameMode.playerVsComputer:
        switch (gameState) {
          case GameState.playerOneVictory:
            if (playerOneToken == BoardToken.x) {
              return winMsg;
            } else {
              return loseMsg;
            }
          case GameState.playerTwoVictory:
            if (playerOneToken == BoardToken.o) {
              return winMsg;
            } else {
              return loseMsg;
            }
          case GameState.draw:
            return drawMsg;
          default:
            return "";
        }
      case GameMode.playerVsPlayer:
        switch (gameState) {
          case GameState.playerOneVictory:
            return playerOneToken == BoardToken.x
                ? "Player 1 wins!"
                : "Player 2 wins";
          case GameState.playerTwoVictory:
            return playerOneToken == BoardToken.o
                ? "Player 1 wins!"
                : "Player 2 wins";
          case GameState.draw:
            return drawMsg;
          default:
            return "";
        }
    }
  }

  String _determineWinningTokenText() {
    switch (gameState) {
      case GameState.playerOneVictory:
        return "X";
      case GameState.playerTwoVictory:
        return "O";
      case GameState.draw:
        return "";
      default:
        return "";
    }
  }

  Color? _winnerTextColour(ThemeData theme) {
    switch (gameState) {
      case GameState.playerOneVictory:
        return theme.colorScheme.primary;
      case GameState.playerTwoVictory:
        return theme.colorScheme.secondary;
      case GameState.draw:
        return theme.colorScheme.onSurface;
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Text(_determineHeaderText()),
        Row(
          children: [
            Text(
              _determineWinningTokenText(),
              style: theme.textTheme.displayLarge!.copyWith(
                color: _winnerTextColour(theme),
                fontWeight: FontWeight.bold,
              ),
            ),
            if (gameState != GameState.draw) const SizedBox(width: 8),
            Text(
              gameState == GameState.draw
                  ? "NO ONE TAKES THE ROUND"
                  : _determineWinningTokenText() != ""
                      ? "TAKES THE ROUND"
                      : "",
              style: theme.textTheme.headlineSmall!.copyWith(
                color: _winnerTextColour(theme),
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        )
      ],
    );
  }
}
