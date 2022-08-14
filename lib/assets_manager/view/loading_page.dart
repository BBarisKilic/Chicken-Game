import 'package:chicken_game/l10n/l10n.dart';
import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key, required double progress})
      : _progress = progress;

  final double _progress;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('${l10n.localeName} $_progress'),
          LinearProgressIndicator(
            value: _progress,
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}
