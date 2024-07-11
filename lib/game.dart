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
    log("Position: ${(position.row, position.col)}", name: "makeMove");

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
    return buildBoard(context);
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
              style: theme.textTheme.bodyLarge,
            ),
          ),
        ));
  }
}
