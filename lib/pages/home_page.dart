import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../services/api_service.dart';
import '../widgets/salinity_display.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double? _salinity;
  String? _error;
  bool _isLoading = true;

  final RefreshController _refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
    _checkWifiAndFetch();
  }

  Future<void> _checkWifiAndFetch() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final value = await ApiService.fetchSalinity();
      setState(() {
        _salinity = value;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _salinity = null;
      });
    }

    setState(() {
      _isLoading = false;
    });

    _refreshController.refreshCompleted();
  }

  Widget _buildErrorCard() {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return GestureDetector(
      onTap: _checkWifiAndFetch,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 5,
        margin: const EdgeInsets.all(16),
        color: scheme.errorContainer,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.error_outline,
                color: scheme.onErrorContainer,
                size: 48,
              ),
              const SizedBox(height: 16),
              Text(
                _error ?? "Erreur inconnue",
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: scheme.onErrorContainer,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Appuyez pour réessayer',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: scheme.onErrorContainer.withOpacity(0.6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Salinité'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.pushNamed(context, '/settings'),
            color: theme.appBarTheme.foregroundColor,
          ),
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _checkWifiAndFetch,
        child: Center(
          child: _isLoading
              ? SpinKitFadingCircle(color: scheme.primary, size: 50)
              : _error != null
              ? _buildErrorCard()
              : SalinityDisplay(
                  value: _salinity!,
                  onRefresh: _checkWifiAndFetch,
                ),
        ),
      ),
    );
  }
}
