import 'package:flutter/material.dart';

class StatBlock extends StatelessWidget {
  final Color? backgroundColour;
  final Color? textColour;

  const StatBlock(
      {super.key,
      required this.statName,
      required this.statValue,
      this.backgroundColour,
      this.textColour});
  final String statName;
  final int statValue;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColour ?? theme.colorScheme.primary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            statName,
            style: theme.textTheme.bodyMedium!.copyWith(
              color: textColour ?? theme.colorScheme.onPrimary,
            ),
          ),
          Text(
            statValue.toString(),
            style: theme.textTheme.titleLarge!.copyWith(
              color: textColour ?? theme.colorScheme.onPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class StatsRow extends StatelessWidget {
  const StatsRow({
    super.key,
    required this.xWins,
    required this.draws,
    required this.theme,
    required this.oWins,
  });

  final int xWins;
  final int draws;
  final ThemeData theme;
  final int oWins;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: StatBlock(
              statName: "X WINS",
              statValue: xWins,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: StatBlock(
              statName: "DRAwS",
              statValue: draws,
              backgroundColour: theme.colorScheme.surfaceContainer,
              textColour: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: StatBlock(
              statName: "O WINS",
              statValue: oWins,
              backgroundColour: theme.colorScheme.secondary,
              textColour: theme.colorScheme.onSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
