import 'package:bloc_test/bloc_test.dart';
import 'package:chicken_game/assets_manager/assets_manager.dart';
import 'package:chicken_game/injector.dart' as di;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

class _MockAssetsManagerCubit extends MockCubit<AssetsManagerState>
    implements AssetsManagerCubit {}

void main() {
  late _MockAssetsManagerCubit mockAssetsManagerCubit;

  setUpAll(() async {
    mockAssetsManagerCubit = _MockAssetsManagerCubit();

    await di.initializeDependencies();
    await di.injector.unregister<AssetsManagerCubit>();

    di.injector
        .registerFactory<AssetsManagerCubit>(() => mockAssetsManagerCubit);
  });

  void arrangeState(AssetsManagerState state) {
    when(() => mockAssetsManagerCubit.state).thenReturn(state);
  }

  tearDownAll(() async {
    await di.injector.reset();
  });

  group('LoadingPage', () {
    testWidgets('renders LinearProgressIndicator', (tester) async {
      await tester.pumpApp(
        const LoadingPage(progress: 0),
      );

      expect(find.byType(LinearProgressIndicator), findsOneWidget);
    });

    testWidgets('shows correct progress', (tester) async {
      arrangeState(const AssetsManagerState(assetsCount: 2, loaded: 1));

      await tester.pumpApp(
        LoadingPage(progress: mockAssetsManagerCubit.state.progress),
      );

      final finder = find.byType(LinearProgressIndicator);
      final linearProgressIndicator =
          finder.evaluate().single.widget as LinearProgressIndicator;

      expect(linearProgressIndicator.value, equals(0.5));
    });
  });
}
