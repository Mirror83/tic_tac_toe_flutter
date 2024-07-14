import 'dart:async';
import 'dart:math' show Random;

import 'package:flutter/material.dart';
import 'package:tic_tac_toe/board.dart';
import 'dart:developer' show log;

enum GameMode {
  playerVsPlayer,
  playerVsComputer,
}

class TicTacToeGame extends StatefulWidget {
  final GameMode gameMode;
  const TicTacToeGame({super.key, this.gameMode = GameMode.playerVsComputer});

  @override
  State<TicTacToeGame> createState() => _TicTacToeGameState();
}

class _TicTacToeGameState extends State<TicTacToeGame> {
  final TicTacToeBoard board = TicTacToeBoard();

  var computerIsMoving = false;

  var gameState = GameState.playerOneTurn;
  final _tag = "TicTacToeGame";

  String determineHeaderText() {
    switch (gameState) {
      case GameState.playerOneTurn:
        return "X's turn.";
      case GameState.playerTwoTurn:
        return "O's turn.";
      case GameState.playerOneVictory:
        return "X wins!";
      case GameState.playerTwoVictory:
        return "O wins!";
      case GameState.draw:
        return "It's a draw";
    }
  }

  void evaluateBoard() {
    setState(() {
      if (board.checkForWin() == true) {
        if (gameState == GameState.playerOneTurn) {
          gameState = GameState.playerOneVictory;
        } else {
          gameState = GameState.playerTwoVictory;
        }
      } else if (board.checkForDraw() == true) {
        gameState = GameState.draw;
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
    Timer(Duration(seconds: Random().nextInt(1) + 6), () {
      final computerPosition = board.minimaxSearch();

      if (computerPosition != null) {
        board.placeToken(computerPosition, BoardToken.o);
      }
      evaluateBoard();

      setState(() {
        computerIsMoving = false;
      });
    });
  }

  void makeMove(BoardPosition position) {
    switch (gameState) {
      case GameState.playerOneTurn:
        board.placeToken(position, BoardToken.x);
        // Check board for new game state
        evaluateBoard();

        if (widget.gameMode == GameMode.playerVsComputer) {
          makeComputerMove();
        }

        break;
      case GameState.playerTwoTurn:
        if (widget.gameMode == GameMode.playerVsPlayer) {
          board.placeToken(position, BoardToken.o);
          // Check board for new game state
          evaluateBoard();
        }
        break;
      case GameState.playerOneVictory:
        log("Player one wins!", name: _tag);
        break;
      case GameState.playerTwoVictory:
        log("Player two wins!", name: _tag);
        break;
      case GameState.draw:
        log("Game is a draw", name: _tag);
        break;
    }
  }

  Widget buildHeader(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const PseudoLogo(),
            Text(determineHeaderText()),
            TextButton(
              onPressed: () {
                board.clearBoard();
                setState(() {
                  gameState = GameState.playerOneTurn;
                });
              },
              child: const Text("Refresh"),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoard(BuildContext context) {
    final List<BoardTile> boardTiles = [];

    for (var (i, row) in board.board.indexed) {
      for (var (j, token) in row.indexed) {
        boardTiles.add(
          BoardTile(
            token: token,
            placeToken: makeMove,
            canPlaceToken: !computerIsMoving,
            position: BoardPosition(
              row: i,
              col: j,
            ),
          ),
        );
      }
    }

    return Row(
      children: [
        Expanded(
          child: Center(
            child: SizedBox(
              width: 320,
              height: 400,
              child: GridView.count(
                crossAxisCount: 3,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                children: [...boardTiles],
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildHeader(context),
        buildBoard(context),
      ],
    );
  }
}

class PseudoLogo extends StatelessWidget {
  const PseudoLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return RichText(
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
  }
}

class BoardTile extends StatefulWidget {
  final BoardPosition position;
  final void Function(BoardPosition) placeToken;
  final bool canPlaceToken;
  final BoardToken token;

  const BoardTile(
      {super.key,
      required this.token,
      required this.placeToken,
      required this.position,
      required this.canPlaceToken});

  @override
  State<BoardTile> createState() => _BoardTileState();
}

class _BoardTileState extends State<BoardTile> {
  String tokenToString() {
    switch (widget.token) {
      case BoardToken.x:
        return "X";
      case BoardToken.o:
        return "O";
      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
        onTap: () {
          if (widget.canPlaceToken) {
            widget.placeToken(widget.position);
          } else {
            log("Cannot place token yet.", name: "placeTokenBoardTile");
          }
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Text(
              tokenToString(),
              style: theme.textTheme.headlineLarge,
            ),
          ),
        ));
  }
}
