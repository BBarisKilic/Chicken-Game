import 'package:bloc_test/bloc_test.dart';
import 'package:chicken_game/assets_manager/assets_manager.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_game.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late TestGame game;
  late AssetsManagerCubit assetsManagerCubit;

  setUp(() async {
    game = TestGame();
    assetsManagerCubit = AssetsManagerCubit(game: game);
  });

  group('AssetsManagerCubit', () {
    test('initial state has 0 assetsCount', () {
      expect(assetsManagerCubit.state.assetsCount, equals(0));
    });

    test('initial state has 0 loaded', () {
      expect(assetsManagerCubit.state.loaded, equals(0));
    });

    test('initial state has 0 progress', () {
      expect(assetsManagerCubit.state.progress, equals(0));
    });

    test('initial state is loading assets', () {
      expect(assetsManagerCubit.state.isLoading, isTrue);
    });

    blocTest<AssetsManagerCubit, AssetsManagerState>(
      'loads all assets',
      build: () => AssetsManagerCubit(game: game),
      act: (cubit) async => cubit.load(),
      wait: const Duration(seconds: 2),
      expect: () => const [
        AssetsManagerState(assetsCount: 2, loaded: 0),
        AssetsManagerState(assetsCount: 2, loaded: 1),
        AssetsManagerState(assetsCount: 2, loaded: 2),
      ],
    );
  });
}
