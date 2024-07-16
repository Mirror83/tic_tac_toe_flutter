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

  @override
  bool operator ==(Object other) {
    if (other is BoardPosition) {
      return row == other.row && col == other.col;
    }

    return false;
  }

  @override
  String toString() {
    return "BoardPosition(row: $row, col: $col)";
  }

  @override
  int get hashCode => (row, col).hashCode;
}

class TicTacToeBoard {
  List<List<BoardToken>> board = [];

  // Thie startBoard parameter is for testing purposes only.
  TicTacToeBoard({List<List<BoardToken>>? startBoard}) {
    if (startBoard != null) {
      board = startBoard;
    } else {
      _initializeBoard();
    }
  }

  void _initializeBoard() {
    for (int row = 0; row < rows; row++) {
      board.add([]);
      for (int col = 0; col < cols; col++) {
        board[row].add(BoardToken.empty);
      }
    }
  }

  void clearBoard() {
    for (int row = 0; row < rows; row++) {
      for (int col = 0; col < cols; col++) {
        board[row][col] = BoardToken.empty;
      }
    }
  }

  void forEach(void Function(List<BoardToken>) action) {
    board.forEach(action);
  }

  /// Returns false if [token] cannot be placed at [position].
  /// Otherwise places [token] at [position] and returns true
  bool placeToken(BoardPosition position, BoardToken token) {
    if (position.isValid() &&
        token != BoardToken.empty &&
        board[position.row][position.col] == BoardToken.empty) {
      // Only place token if position is empty.
      board[position.row][position.col] = token;
      return true;
    }

    return false;
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

  bool _isTerminalState() {
    return checkForWin() || checkForDraw();
  }

  int _utility(BoardToken currentPlayer) {
    if (checkForDraw()) {
      return 0;
    }

    if (currentPlayer == BoardToken.x) {
      return 1;
    } else {
      return -1;
    }
  }

  BoardPosition? minimaxSearch(BoardToken computerToken) {
    final (_, move) = computerToken == BoardToken.x
        ? _maxValue(currentPlayer: BoardToken.x)
        : _minValue(currentPlayer: BoardToken.o);

    return move;
  }

  (int, BoardPosition?) _maxValue({BoardToken currentPlayer = BoardToken.x}) {
    // Check for terminal states and determine utility
    if (_isTerminalState()) {
      return (_utility(BoardToken.o), null);
    }

    // If not in terminal state, carry out max part of minimax algorithm
    int bestScore = -1000;
    BoardPosition? bestMove;

    // For each action in the set of possible actions from the current position
    for (int row = 0; row < rows; row++) {
      for (int col = 0; col < cols; col++) {
        if (board[row][col] == BoardToken.empty) {
          board[row][col] = currentPlayer;

          final (newValue, _) = _minValue(currentPlayer: BoardToken.o);

          if (newValue > bestScore) {
            bestScore = newValue;
            bestMove = BoardPosition(row: row, col: col);
          }

          // Undo move, since we are modifying the board in-place
          board[row][col] = BoardToken.empty;
        }
      }
    }

    return (bestScore, bestMove);
  }

  (int, BoardPosition?) _minValue({BoardToken currentPlayer = BoardToken.o}) {
    // Check for terminal states and determine utility
    if (_isTerminalState()) {
      return (_utility(BoardToken.x), null);
    }
    // If not in terminal state, carry out max part of minimax algorithm
    int bestScore = 1000;
    BoardPosition? move;

    // For each action in the set of possible actions from the current position
    for (int row = 0; row < rows; row++) {
      for (int col = 0; col < cols; col++) {
        if (board[row][col] == BoardToken.empty) {
          board[row][col] = currentPlayer;

          final (newValue, _) = _maxValue(currentPlayer: BoardToken.x);

          if (newValue < bestScore) {
            bestScore = newValue;
            move = BoardPosition(row: row, col: col);
          }

          // Undo move, since we are modifying the board in-place
          board[row][col] = BoardToken.empty;
        }
      }
    }

    return (bestScore, move);
  }
}
