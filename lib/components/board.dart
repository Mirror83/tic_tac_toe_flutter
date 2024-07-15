import 'package:flutter/material.dart';
import 'package:tic_tac_toe/board.dart';
import 'package:tic_tac_toe/components/board_tile.dart';

class Board extends StatelessWidget {
  final TicTacToeBoard board;
  final void Function(BoardPosition) makeMove;
  final bool computerIsMoving;

  const Board(
      {super.key,
      required this.board,
      required this.makeMove,
      required this.computerIsMoving});

  @override
  Widget build(BuildContext context) {
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
}
