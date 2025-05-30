import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SalinityListView extends StatelessWidget {
  final List<Map<String, dynamic>> history;
  const SalinityListView({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return ListView.builder(
      itemCount: history.length,
      itemBuilder: (context, index) {
        // Show latest first in list
        final item = history[history.length - 1 - index];
        final value = item['value'] as double;
        final timestamp = item['timestamp'] as DateTime;

        return ListTile(
          title: Text(
            '${value.toStringAsFixed(4)} g/L',
            style: TextStyle(
              color: colorScheme.onPrimaryContainer,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            DateFormat('yyyy-MM-dd HH:mm:ss').format(timestamp),
            style: TextStyle(
              color: colorScheme.onPrimaryContainer.withOpacity(0.85),
            ),
          ),
        );
      },
    );
  }
}
