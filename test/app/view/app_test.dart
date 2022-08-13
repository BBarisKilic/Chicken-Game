import 'package:bloc_test/bloc_test.dart';
import 'package:chicken_game/app/app.dart';
import 'package:chicken_game/assets_manager/assets_manager.dart';
import 'package:chicken_game/game/game.dart';
import 'package:chicken_game/injector.dart' as di;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockChickenGame extends Mock implements ChickenGame {}

class MockAssetsManagerCubit extends MockCubit<AssetsManagerState>
    implements AssetsManagerCubit {}

class FakeAssetsManagerState extends Fake implements AssetsManagerState {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockChickenGame mockChickenGame;
  late MockAssetsManagerCubit mockAssetsManagerCubit;

  setUpAll(() async {
    registerFallbackValue(FakeAssetsManagerState());

    mockChickenGame = MockChickenGame();
    mockAssetsManagerCubit = MockAssetsManagerCubit();

    await di.initializeDependencies();

    await di.injector.unregister<ChickenGame>();
    await di.injector.unregister<AssetsManagerCubit>();

    di.injector
      ..registerLazySingleton<ChickenGame>(() => mockChickenGame)
      ..registerFactory<AssetsManagerCubit>(() => mockAssetsManagerCubit);
  });

  tearDownAll(() async {
    await di.injector.reset();
  });

  void arrangeState() {
    when(() => mockAssetsManagerCubit.state)
        .thenReturn(const AssetsManagerState.initial());
  }

  void arrangeLoad() {
    when(() => mockAssetsManagerCubit.load()).thenAnswer((_) async {});
  }

  group('App', () {
    testWidgets('renders ChickenGamePage', (tester) async {
      arrangeState();
      arrangeLoad();

      await tester.pumpWidget(const App());
      await tester.pump();

      expect(find.byType(ChickenGamePage), findsOneWidget);
    });
  });
}
