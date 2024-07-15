import 'package:flutter/material.dart';

class PseudoLogo extends StatelessWidget {
  const PseudoLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return RichText(
        text: TextSpan(
            text: "X",
            style: TextStyle(
                color: theme.colorScheme.primary,
                fontSize: theme.textTheme.displayMedium!.fontSize,
                fontWeight: FontWeight.w600),
            children: [
          TextSpan(
              text: "O",
              style: TextStyle(
                color: theme.colorScheme.secondary,
              ))
        ]));
  }
}
