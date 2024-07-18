import 'package:flutter/material.dart';
import 'package:tic_tac_toe/components/pseudo_logo.dart';

class Header extends StatelessWidget {
  final String gameInfo;
  final void Function() refreshBoardCallBack;
  const Header(
      {super.key, required this.gameInfo, required this.refreshBoardCallBack});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const PseudoLogo(),
          Text(gameInfo),
          RefreshButton(refreshBoardCallBack: refreshBoardCallBack),
        ],
      ),
    );
  }
}

class RefreshButton extends StatelessWidget {
  const RefreshButton({
    super.key,
    required this.refreshBoardCallBack,
  });

  final void Function() refreshBoardCallBack;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: refreshBoardCallBack,
      icon: const Icon(Icons.refresh),
    );
  }
}
