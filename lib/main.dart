import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
          body: Column(
        children: [
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("XO"),
                  Text("X's turn"),
                  Text("Refresh")
                ],
              ),
            ),
          ),
          Row(),
          Row(),
        ],
      )),
    );
  }
}
