import 'dart:developer' show log;

import 'package:flutter/material.dart';
import 'package:tic_tac_toe/board.dart';

class BoardTile extends StatefulWidget {
  final BoardPosition position;
  final void Function(BoardPosition) placeToken;
  final bool canPlaceToken;
  final BoardToken token;

  const BoardTile(
      {super.key,
      required this.token,
      required this.placeToken,
      required this.position,
      required this.canPlaceToken});

  @override
  State<BoardTile> createState() => _BoardTileState();
}

class _BoardTileState extends State<BoardTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> animation;

  double borderWidth = 8;

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
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
          onTapUp: (details) {
            setState(() {
              borderWidth = 8;
            });
          },
          onTapDown: ((details) {
            setState(() {
              borderWidth = 6;
            });
          }),
          onTap: () {
            if (widget.canPlaceToken) {
              widget.placeToken(widget.position);
              _controller.reset();
              _controller.forward();
            } else {
              log("Cannot place token yet.", name: "placeTokenBoardTile");
            }
          },
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainer,
              border: BorderDirectional(
                  bottom: BorderSide(
                width: borderWidth,
                color: theme.colorScheme.shadow,
              )),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: FadeTransition(
                opacity: animation,
                child: Text(
                  tokenToString(),
                  style: theme.textTheme.displaySmall!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: determineTokenColour(theme),
                  ),
                ),
              ),
            ),
          )),
    );
  }

  Color? determineTokenColour(ThemeData theme) {
    return widget.token == BoardToken.x
        ? theme.colorScheme.primary
        : widget.token == BoardToken.o
            ? theme.colorScheme.secondary
            : null;
  }
}
