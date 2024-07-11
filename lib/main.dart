import 'package:flutter/material.dart';
import "dart:developer" as dev;

const board = ["", "", "", "", "", "", "", "", ""];

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF192A32),
          primary: const Color(0xFF2FC5BD),
          secondary: const Color(0xFFF2B237),
        ),
      ),
      home: Scaffold(
          body: Column(
        children: [
          buildHeader(context),
          buildBoard(context),
          const Row(),
        ],
      )),
    );
  }

  Widget buildHeader(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final pseudoLogo = RichText(
        text: TextSpan(
            text: "X",
            style: TextStyle(
                color: theme.colorScheme.primary,
                fontSize: theme.textTheme.displayMedium!.fontSize),
            children: [
          TextSpan(
              text: "O",
              style: TextStyle(
                color: theme.colorScheme.secondary,
              ))
        ]));

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            pseudoLogo,
            const Text("X's turn"),
            const Text("Refresh")
          ],
        ),
      ),
    );
  }

  Widget buildBoard(BuildContext context) {
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
                children: [
                  ...board.map((token) => GridTile(token: token.toString()))
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class GridTile extends StatefulWidget {
  const GridTile({super.key, required this.token});

  final String token;

  @override
  State<GridTile> createState() => _GridTileState();
}

class _GridTileState extends State<GridTile> {
  bool isActive = false;

  void toggleIsActive() {
    setState(() {
      dev.log("Changed isActive from: $isActive");
      isActive = !isActive;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: toggleIsActive,
      child: Container(
        decoration: BoxDecoration(
          color: isActive ? theme.colorScheme.primary : null,
          border: Border.all(),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(
          child: Text(widget.token,
              style: theme.textTheme.bodyLarge!.copyWith(
                  color: isActive
                      ? theme.colorScheme.onPrimary
                      : theme.colorScheme.onSurface)),
        ),
      ),
    );
  }
}
