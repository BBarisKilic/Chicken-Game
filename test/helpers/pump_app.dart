import 'package:chicken_game/assets_manager/assets_manager.dart';
import 'package:chicken_game/injector.dart' as di;
import 'package:chicken_game/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

extension PumpApp on WidgetTester {
  Future<void> pumpApp(
    Widget widget, {
    AssetsManagerCubit? assetsManagerCubit,
  }) async {
    return pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) =>
                assetsManagerCubit ?? di.injector<AssetsManagerCubit>()
                  ..load(),
          ),
        ],
        child: MaterialApp(
          title: 'Test Game',
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: widget,
        ),
      ),
    );
  }
}
