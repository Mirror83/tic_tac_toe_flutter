import "package:flutter_test/flutter_test.dart";
import "package:tic_tac_toe/board.dart";

void main() {
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
