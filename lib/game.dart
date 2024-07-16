import 'dart:async';
import 'dart:math' show Random;

import 'package:flutter/material.dart';
import 'package:tic_tac_toe/board.dart';
import 'package:tic_tac_toe/components/board.dart';
import 'dart:developer' show log;

import 'package:tic_tac_toe/components/header.dart';

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

  String determineGameInfoText() {
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

        if (widget.gameMode == GameMode.playerVsComputer &&
            gameState == GameState.playerTwoTurn) {
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Header(
              gameInfo: determineGameInfoText(),
              refreshBoardCallBack: () {
                board.clearBoard();
                setState(() {
                  gameState = GameState.playerOneTurn;
                });
              },
            ),
            Board(
              board: board,
              makeMove: makeMove,
              computerIsMoving: computerIsMoving,
            ),
          ],
        ),
      ),
    );
  }
}
