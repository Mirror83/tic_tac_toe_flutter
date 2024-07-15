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
          TextButton(
            onPressed: refreshBoardCallBack,
            child: const Text("Refresh"),
          ),
        ],
      ),
    );
  }
}
