import "package:flutter_test/flutter_test.dart";
import "package:tic_tac_toe/board.dart";

void main() {
  test("minimax search", () {
    final board = TicTacToeBoard(startBoard: [
      [BoardToken.x, BoardToken.x, BoardToken.o],
      [BoardToken.o, BoardToken.o, BoardToken.empty],
      [BoardToken.x, BoardToken.x, BoardToken.empty],
    ]);

    final board2 = TicTacToeBoard(startBoard: [
      [BoardToken.x, BoardToken.x, BoardToken.o],
      [BoardToken.o, BoardToken.o, BoardToken.x],
      [BoardToken.x, BoardToken.x, BoardToken.o],
    ]);

    expect(board.minimaxSearch(BoardToken.o), BoardPosition(row: 1, col: 2));
    expect(board.minimaxSearch(BoardToken.x), BoardPosition(row: 2, col: 2));

    expect(board2.minimaxSearch(BoardToken.o), null);
    expect(board2.minimaxSearch(BoardToken.x), null);
  });
  test("check empty board for win", () {
    final board = TicTacToeBoard();

    expect(board.checkForWin(), isFalse);
  });

  test("check empty board for draw", () {
    final board = TicTacToeBoard();

    expect(board.checkForDraw(), isFalse);
  });

  test("place token", () {
    final board = TicTacToeBoard();

    expect(
        board.board
            .every((row) => row.every((token) => token == BoardToken.empty)),
        isTrue);

    board.placeToken(BoardPosition(row: 0, col: 0), BoardToken.x);

    final List<BoardToken> xTokens = [];
    for (var row in board.board) {
      for (var token in row) {
        if (token == BoardToken.x) xTokens.add(token);
      }
    }
    expect(xTokens.length, 1);
  });

  test("check for diagonal win", () {
    final board = TicTacToeBoard(startBoard: [
      [BoardToken.x, BoardToken.empty, BoardToken.empty],
      [BoardToken.empty, BoardToken.x, BoardToken.empty],
      [BoardToken.empty, BoardToken.empty, BoardToken.x],
    ]);

    final board2 = TicTacToeBoard(startBoard: [
      [BoardToken.empty, BoardToken.empty, BoardToken.o],
      [BoardToken.empty, BoardToken.o, BoardToken.empty],
      [BoardToken.o, BoardToken.empty, BoardToken.x],
    ]);

    expect(board.checkForWin(), isTrue);
    expect(board2.checkForWin(), isTrue);
  });

  test("check for vertical win", () {
    final board = TicTacToeBoard(startBoard: [
      [BoardToken.x, BoardToken.empty, BoardToken.empty],
      [BoardToken.x, BoardToken.empty, BoardToken.empty],
      [BoardToken.x, BoardToken.empty, BoardToken.empty],
    ]);

    final board2 = TicTacToeBoard(startBoard: [
      [BoardToken.empty, BoardToken.x, BoardToken.o],
      [BoardToken.empty, BoardToken.x, BoardToken.x],
      [BoardToken.empty, BoardToken.x, BoardToken.o],
    ]);

    final board3 = TicTacToeBoard(startBoard: [
      [BoardToken.empty, BoardToken.o, BoardToken.x],
      [BoardToken.empty, BoardToken.x, BoardToken.x],
      [BoardToken.empty, BoardToken.x, BoardToken.x],
    ]);

    expect(board.checkForWin(), isTrue);
    expect(board2.checkForWin(), isTrue);
    expect(board3.checkForWin(), isTrue);
  });

  test("check for horizontal win", () {
    final board = TicTacToeBoard(startBoard: [
      [BoardToken.x, BoardToken.x, BoardToken.x],
      [BoardToken.empty, BoardToken.empty, BoardToken.empty],
      [BoardToken.empty, BoardToken.empty, BoardToken.empty],
    ]);

    final board2 = TicTacToeBoard(startBoard: [
      [BoardToken.empty, BoardToken.x, BoardToken.o],
      [BoardToken.x, BoardToken.x, BoardToken.x],
      [BoardToken.empty, BoardToken.o, BoardToken.o],
    ]);

    final board3 = TicTacToeBoard(startBoard: [
      [BoardToken.empty, BoardToken.empty, BoardToken.empty],
      [BoardToken.empty, BoardToken.empty, BoardToken.empty],
      [BoardToken.o, BoardToken.o, BoardToken.o],
    ]);

    expect(board.checkForWin(), isTrue);
    expect(board2.checkForWin(), isTrue);
    expect(board3.checkForWin(), isTrue);
  });
}
