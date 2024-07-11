const rows = 3;
const cols = 3;

enum BoardToken {
  empty,
  x,
  o,
}

enum GameState {
  playerOneTurn,
  playerTwoTurn,
  playerOneVictory,
  playerTwoVictory,
  draw,
}

class BoardPosition {
  final int row;
  final int col;

  BoardPosition({required this.row, required this.col});

  bool isValid() {
    return row >= 0 && row < rows && col >= 0 && col < cols;
  }
}

class TicTacToeBoard {
  List<List<BoardToken>> board =
      List.filled(rows, List.filled(cols, BoardToken.empty));

  // This custom constructor is for testing purposes only.
  TicTacToeBoard({List<List<BoardToken>>? startBoard}) {
    if (startBoard != null) {
      board = startBoard;
    }
  }

  void placeToken(BoardPosition position, BoardToken token) {
    assert(position.isValid() && token != BoardToken.empty);

    // Only place token if position is empty.
    if (board[position.row][position.col] == BoardToken.empty) {
      board[position.row][position.col] = token;
    }
  }

  bool _checkForHorizontalWin() {
    for (final row in board) {
      if (row[0] == row[1] && row[1] == row[2] && row[0] != BoardToken.empty) {
        return true;
      }
    }

    return false;
  }

  bool _checkForVerticalWin() {
    for (int col = 0; col < cols; col++) {
      if (board[0][col] == board[1][col] &&
          board[1][col] == board[2][col] &&
          board[0][col] != BoardToken.empty) {
        return true;
      }
    }

    return false;
  }

  bool _checkForDiagonalWin() {
    if (board[0][0] == board[1][1] &&
        board[1][1] == board[2][2] &&
        board[0][0] != BoardToken.empty) {
      return true;
    }

    if (board[0][2] == board[1][1] &&
        board[1][1] == board[2][0] &&
        board[0][2] != BoardToken.empty) {
      return true;
    }

    return false;
  }

  bool checkForWin() {
    if (_checkForHorizontalWin() ||
        _checkForVerticalWin() ||
        _checkForDiagonalWin()) {
      return true;
    }
    return false;
  }

  bool checkForDraw() {
    return !checkForWin() &&
        board.every((row) => row.every((token) => token != BoardToken.empty));
  }
}
