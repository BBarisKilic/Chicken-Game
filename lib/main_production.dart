import 'package:chicken_game/app/app.dart';
import 'package:chicken_game/bootstrap.dart';
import 'package:chicken_game/injector.dart' as di;
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.initializeDependencies();

  await bootstrap(() => const App());
}
