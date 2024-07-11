import 'package:tic_tac_toe/board.dart';
import 'dart:developer' show log;

class TicTacToeGame {
  final TicTacToeBoard board = TicTacToeBoard();
  var gameState = GameState.playerOneTurn;
  final _tag = "TicTacToeGame";

  makeMove(BoardPosition position) {
    // TODO: Incorporate UI updates and stuff

    switch (gameState) {
      case GameState.playerOneTurn:
        board.placeToken(position, BoardToken.x);
        // Check for board for new game state
        if (board.checkForWin() == true) {
          gameState = GameState.playerOneVictory;
        } else if (board.checkForDraw() == true) {
          gameState = GameState.draw;
        } else {
          gameState = GameState.playerTwoTurn;
        }
        break;
      case GameState.playerTwoTurn:
        board.placeToken(position, BoardToken.x);
        // Check for board for new game state
        if (board.checkForWin() == true) {
          gameState = GameState.playerTwoVictory;
        } else if (board.checkForDraw() == true) {
          gameState = GameState.draw;
        } else {
          gameState = GameState.playerOneTurn;
        }
        break;
      case GameState.playerOneVictory:
        log("Player one wins!", name: _tag);
      case GameState.playerTwoVictory:
        log("Player two wins!", name: _tag);
      case GameState.draw:
        log("Game is a draw", name: _tag);
    }
  }
}
