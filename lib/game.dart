import 'package:flutter/material.dart';
import 'package:tic_tac_toe/board.dart';
import 'dart:developer' show log;

class TicTacToeGame extends StatefulWidget {
  const TicTacToeGame({super.key});

  @override
  State<TicTacToeGame> createState() => _TicTacToeGameState();
}

class _TicTacToeGameState extends State<TicTacToeGame> {
  final TicTacToeBoard board = TicTacToeBoard();
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

  void makeMove(BoardPosition position) {
    switch (gameState) {
      case GameState.playerOneTurn:
        board.placeToken(position, BoardToken.x);
        // Check board for new game state
        setState(() {
          if (board.checkForWin() == true) {
            gameState = GameState.playerOneVictory;
          } else if (board.checkForDraw() == true) {
            gameState = GameState.draw;
          } else {
            gameState = GameState.playerTwoTurn;
          }
        });

        break;
      case GameState.playerTwoTurn:
        board.placeToken(position, BoardToken.o);
        // Check board for new game state
        setState(() {
          if (board.checkForWin() == true) {
            gameState = GameState.playerTwoVictory;
          } else if (board.checkForDraw() == true) {
            gameState = GameState.draw;
          } else {
            gameState = GameState.playerOneTurn;
          }
        });

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

class BoardTile extends StatefulWidget {
  final BoardPosition position;
  final void Function(BoardPosition) placeToken;
  final BoardToken token;

  const BoardTile(
      {super.key,
      required this.token,
      required this.placeToken,
      required this.position});

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
          widget.placeToken(widget.position);
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
