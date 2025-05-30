import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SalinityHistoryWidget extends StatefulWidget {
  const SalinityHistoryWidget({super.key});

  @override
  State<SalinityHistoryWidget> createState() => _SalinityHistoryWidgetState();
}

class _SalinityHistoryWidgetState extends State<SalinityHistoryWidget> {
  List<Map<String, dynamic>> _history = [];

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final history = prefs.getStringList('salinity_history') ?? [];

    final parsed = history.map((entry) {
      final decoded = json.decode(entry);
      return {
        'value': decoded['value'] as double,
        'timestamp':
            DateTime.tryParse(decoded['timestamp']) ??
            DateTime.fromMillisecondsSinceEpoch(0),
      };
    }).toList();

    // Fix: Force DateTime type before using compareTo
    parsed.sort(
      (a, b) =>
          (b['timestamp'] as DateTime).compareTo(a['timestamp'] as DateTime),
    );

    setState(() => _history = parsed);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.symmetric(vertical: 16),
      elevation: 5,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: colorScheme.primaryContainer,
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Historique des salinités',
              style: theme.textTheme.titleMedium?.copyWith(
                color: colorScheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(height: 12),
            if (_history.isEmpty)
              Text(
                'Aucune donnée enregistrée.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onPrimaryContainer.withOpacity(0.7),
                ),
              )
            else
              Flexible(
                child: ListView.builder(
                  itemCount: _history.length,
                  itemBuilder: (context, index) {
                    final item = _history[index];
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
                          color: colorScheme.onPrimaryContainer.withOpacity(
                            0.85,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
