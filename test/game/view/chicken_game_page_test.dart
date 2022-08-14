import 'package:bloc_test/bloc_test.dart';
import 'package:chicken_game/assets_manager/assets_manager.dart';
import 'package:chicken_game/game/game.dart';
import 'package:chicken_game/injector.dart' as di;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

class _MockAssetsManagerCubit extends MockCubit<AssetsManagerState>
    implements AssetsManagerCubit {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late TestGame game;
  late _MockAssetsManagerCubit mockAssetsManagerCubit;

  setUpAll(() async {
    game = TestGame();
    mockAssetsManagerCubit = _MockAssetsManagerCubit();

    await Future.wait<void>(
      game.preLoadAssets().map((loadableBuilder) => loadableBuilder()),
    );

    await di.initializeDependencies();
    await di.injector.unregister<AssetsManagerCubit>();

    di.injector
        .registerFactory<AssetsManagerCubit>(() => mockAssetsManagerCubit);
  });

  tearDownAll(() async {
    await di.injector.reset();
  });

  void arrangeState(AssetsManagerState state) {
    when(() => mockAssetsManagerCubit.state).thenReturn(state);
  }

  void arrangeLoad() {
    when(() => mockAssetsManagerCubit.load()).thenAnswer((_) async {});
  }

  group('ChickenGamePage', () {
    testWidgets('renders LoadingPage', (tester) async {
      arrangeState(const AssetsManagerState.initial());
      arrangeLoad();

      await tester.pumpApp(const ChickenGamePage());
      await tester.pump();

      expect(find.byType(LoadingPage), findsOneWidget);
    });

    testWidgets('renders ChickenGameLoadedView', (tester) async {
      arrangeState(const AssetsManagerState(assetsCount: 1, loaded: 1));
      arrangeLoad();

      await tester.pumpApp(const ChickenGamePage());
      await tester.pump();

      expect(find.byType(ChickenGameLoadedView), findsOneWidget);
    });
  });
}
