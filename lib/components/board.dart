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

  Expanded wrapBoardTileWithExpanded(BoardTile boardTile) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: boardTile,
    ));
  }

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

    final List<Row> rows = [];

    for (int i = 0; i < boardTiles.length; i += 3) {
      final List<Expanded> expandedBoardTiles = [];
      for (int j = 0; j < 3; j++) {
        expandedBoardTiles.add(wrapBoardTileWithExpanded(boardTiles[i + j]));
      }
      rows.add(Row(
        children: [...expandedBoardTiles],
      ));
    }

    // return Padding(
    //   padding: const EdgeInsets.all(16.0),
    //   child: SizedBox(
    //     height: 400,
    //     child: GridView.count(
    //       crossAxisCount: 3,
    //       mainAxisSpacing: 8,
    //       crossAxisSpacing: 8,
    //       children: [...boardTiles],
    //     ),
    //   ),
    // );

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [...rows],
        ),
      ),
    );
  }
}
