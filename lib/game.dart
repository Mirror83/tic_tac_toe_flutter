import 'dart:async';
import 'dart:math' show Random;

import 'package:flutter/material.dart';
import 'package:tic_tac_toe/board.dart';
import 'package:tic_tac_toe/components/board.dart';
import 'package:tic_tac_toe/components/custom_modal.dart';

import 'package:tic_tac_toe/components/header.dart';

enum GameMode {
  playerVsPlayer,
  playerVsComputer,
}

class TicTacToeGame extends StatefulWidget {
  final GameMode gameMode;
  final BoardToken playerOneToken;

  const TicTacToeGame({
    super.key,
    this.gameMode = GameMode.playerVsComputer,
    required this.playerOneToken,
  });

  @override
  State<TicTacToeGame> createState() => _TicTacToeGameState();
}

class _TicTacToeGameState extends State<TicTacToeGame> {
  final board = TicTacToeBoard();
  var gameState = GameState.playerOneTurn;

  var xWins = 0;
  var oWins = 0;
  var draws = 0;

  var computerIsMoving = false;

  var showRestartModal = false;
  var showTerminalStateModal = false;

  void evaluateBoard() {
    setState(() {
      if (board.checkForWin() == true) {
        if (gameState == GameState.playerOneTurn) {
          gameState = GameState.playerOneVictory;
          xWins += 1;
        } else {
          gameState = GameState.playerTwoVictory;
          oWins += 1;
        }
        showTerminalStateModal = true;
      } else if (board.checkForDraw() == true) {
        gameState = GameState.draw;
        draws += 1;
        showTerminalStateModal = true;
      } else if (gameState == GameState.playerOneTurn) {
        gameState = GameState.playerTwoTurn;
      } else if (gameState == GameState.playerTwoTurn) {
        gameState = GameState.playerOneTurn;
      }
    });
  }

  void makeComputerMove() {
    setState(() {
      computerIsMoving = true;
    });
    Timer(Duration(seconds: Random().nextInt(1) + 3), () {
      final computerMark =
          widget.playerOneToken == BoardToken.x ? BoardToken.o : BoardToken.x;

      final computerPosition = board.minimaxSearch(computerMark);

      if (computerPosition != null) {
        board.placeToken(computerPosition, computerMark);
      }
      evaluateBoard();

      setState(() {
        computerIsMoving = false;
      });
    });
  }

  void makeMove(BoardPosition position) {
    switch (widget.playerOneToken) {
      case BoardToken.x:
        switch (gameState) {
          case GameState.playerOneTurn:
            if (!board.placeToken(position, BoardToken.x)) return;
            evaluateBoard();

            if (widget.gameMode == GameMode.playerVsComputer &&
                gameState == GameState.playerTwoTurn) {
              makeComputerMove();
            }

            break;
          case GameState.playerTwoTurn:
            if (widget.gameMode == GameMode.playerVsPlayer) {
              if (!board.placeToken(position, BoardToken.o)) return;
              evaluateBoard();
            }
            break;
          default:
        }
      default:
        switch (gameState) {
          case GameState.playerOneTurn:
            if (widget.gameMode == GameMode.playerVsPlayer) {
              board.placeToken(position, BoardToken.x);
              evaluateBoard();
            }
            break;
          case GameState.playerTwoTurn:
            board.placeToken(position, BoardToken.o);
            evaluateBoard();

            if (widget.gameMode == GameMode.playerVsComputer &&
                gameState == GameState.playerOneTurn) {
              makeComputerMove();
            }
            break;
          default:
        }
    }
  }

  Widget _restartModal() {
    return CustomModal(
      promptWidget: Text(
        "RESTART GAME?",
        style: Theme.of(context)
            .textTheme
            .headlineSmall!
            .copyWith(fontWeight: FontWeight.bold),
      ),
      confirmText: "OK, RESTART",
      cancelText: "NO, CANCEL",
      dismiss: () {
        setState(() {
          showRestartModal = false;
        });
      },
      onCancel: () {
        setState(() {
          showRestartModal = false;
        });
      },
      onConfirm: () {
        board.clearBoard();
        setState(() {
          gameState = GameState.playerOneTurn;
          showRestartModal = false;
        });
        if (widget.gameMode == GameMode.playerVsComputer &&
            widget.playerOneToken == BoardToken.o) {
          makeComputerMove();
        }
      },
    );
  }

  Widget _terminalStateModal() {
    return CustomModal(
      dismiss: () {},
      onConfirm: () {
        setState(() {
          board.clearBoard();
          gameState = GameState.playerOneTurn;
          showTerminalStateModal = false;
        });
        if (widget.gameMode == GameMode.playerVsComputer &&
            widget.playerOneToken == BoardToken.o) {
          makeComputerMove();
        }
      },
      onCancel: () {
        Navigator.of(context).pop();
      },
      promptWidget: TerminalStatePrompt(
        gameMode: widget.gameMode,
        playerOneToken: widget.playerOneToken,
        gameState: gameState,
      ),
      confirmText: "NEXT ROUND",
      cancelText: "QUIT",
    );
  }

  @override
  void initState() {
    super.initState();
    if (widget.gameMode == GameMode.playerVsComputer &&
        widget.playerOneToken == BoardToken.o) makeComputerMove();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: OverflowBox(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Header(
                          gameState: gameState,
                          refreshBoardCallBack: () {
                            setState(() {
                              showRestartModal = true;
                            });
                          },
                        ),
                        Board(
                          board: board,
                          makeMove: makeMove,
                          computerIsMoving: computerIsMoving,
                        ),
                        StatsRow(
                            xWins: xWins,
                            draws: draws,
                            theme: theme,
                            oWins: oWins)
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (showRestartModal) _restartModal(),
            if (showTerminalStateModal) _terminalStateModal(),
          ],
        ),
      ),
    );
  }
}

class StatsRow extends StatelessWidget {
  const StatsRow({
    super.key,
    required this.xWins,
    required this.draws,
    required this.theme,
    required this.oWins,
  });

  final int xWins;
  final int draws;
  final ThemeData theme;
  final int oWins;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: StatBlock(
              statName: "X WINS",
              statValue: xWins,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: StatBlock(
              statName: "DRAwS",
              statValue: draws,
              backgroundColour: theme.colorScheme.surfaceContainer,
              textColour: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: StatBlock(
              statName: "O WINS",
              statValue: oWins,
              backgroundColour: theme.colorScheme.secondary,
              textColour: theme.colorScheme.onSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class StatBlock extends StatelessWidget {
  final Color? backgroundColour;
  final Color? textColour;

  const StatBlock(
      {super.key,
      required this.statName,
      required this.statValue,
      this.backgroundColour,
      this.textColour});
  final String statName;
  final int statValue;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
          color: backgroundColour ?? theme.colorScheme.primary,
          borderRadius: BorderRadius.circular(16),
          border: const BorderDirectional(bottom: BorderSide(width: 4))),
      child: Column(
        children: [
          Text(
            statName,
            style: theme.textTheme.bodyMedium!.copyWith(
              color: textColour ?? theme.colorScheme.onPrimary,
            ),
          ),
          Text(
            statValue.toString(),
            style: theme.textTheme.titleLarge!.copyWith(
              color: textColour ?? theme.colorScheme.onPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
