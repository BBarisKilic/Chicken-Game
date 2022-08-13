import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key, required double progress})
      : _progress = progress;

  final double _progress;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: LinearProgressIndicator(
          value: _progress,
          color: Colors.red,
        ),
      ),
    );
  }
}
