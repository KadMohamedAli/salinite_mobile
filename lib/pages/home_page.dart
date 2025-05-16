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

  Future<void> _fetchSalinity() async {
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
      });
    }

    setState(() {
      _isLoading = false;
    });
    _refreshController.refreshCompleted();
  }

  @override
  void initState() {
    super.initState();
    _fetchSalinity();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Salinité'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.pushNamed(context, '/settings'),
          ),
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _fetchSalinity,
        child: Center(
          child: _isLoading
              ? const SpinKitFadingCircle(color: Colors.teal, size: 50)
              : _error != null
              ? Text(
                  _error!,
                  style: const TextStyle(color: Colors.red, fontSize: 18),
                )
              : SalinityDisplay(value: _salinity!, onRefresh: _fetchSalinity),
        ),
      ),
    );
  }
}
