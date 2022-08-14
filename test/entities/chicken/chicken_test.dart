// ignore_for_file: cascade_invocations

import 'package:chicken_game/entities/entities.dart';
import 'package:flame/extensions.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_game.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Chicken', () {
    final flameTester = FlameTester<TestGame>(TestGame.new);

    flameTester.test('loads correctly', (game) async {
      final chicken = Chicken.wasd();

      await game.ready();
      await game.ensureAdd(chicken);

      expect(game.contains(chicken), isTrue);
    });

    flameTester.test('positioned correctly', (game) async {
      final chicken = Chicken.arrows(center: Vector2.zero());

      await game.ready();
      await game.ensureAdd(chicken);

      expect(chicken.position, closeToVector(Vector2(0, 0)));
    });
  });
}
