import 'package:chicken_game/assets_manager/assets_manager.dart';
import 'package:chicken_game/game/game.dart';
import 'package:chicken_game/injector.dart' as di;
import 'package:chicken_game/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.injector<AssetsManagerCubit>()..load()),
      ],
      child: const MaterialApp(
        title: 'Chicken Game',
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: ChickenGamePage(),
      ),
    );
  }
}
