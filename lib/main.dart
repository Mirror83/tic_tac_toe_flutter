import 'package:flutter/material.dart';
import 'package:tic_tac_toe/mode_selection.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  ThemeData _themeData() {
    final themeData = ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          primary: Color(0xFF2FC5BD),
          secondary: Color(0xFFF2B237),
          tertiary: Color(0xFFA9BEC9),
          error: Colors.red,
          shadow: Color(0xFF102028),
          surface: Color(0xFF192A32),
          surfaceContainer: Color(0xFF1E3640),
          onPrimary: Color(0xFF0D4E50),
          onSecondary: Color(0xFF573B00),
          onTertiary: Color(0xFF263B44),
          onError: Colors.black,
          onSurface: Color(0xFFA9BEC9),
        ));

    return themeData.copyWith(
      textTheme: themeData.textTheme.copyWith(
        bodySmall: themeData.textTheme.bodySmall!.copyWith(
          color: Colors.grey,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _themeData(),
      home: const ModeSelection(),
    );
  }
}
