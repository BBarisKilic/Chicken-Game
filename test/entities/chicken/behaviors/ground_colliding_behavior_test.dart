// ignore_for_file: cascade_invocations

import 'package:chicken_game/components/ground.dart';
import 'package:chicken_game/entities/entities.dart';
import 'package:flame/game.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/helpers.dart';

class _MockGround extends Mock implements Ground {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('GroundCollidingBehavior', () {
    final flameTester = FlameTester<TestGame>(TestGame.new);

    flameTester.test('stops when the collision start', (game) async {
      final behavior = GroundCollidingBehavior();
      final chicken = Chicken.test(
        velocity: Vector2(0, 10),
        behavior: behavior,
      );

      await game.ready();
      await game.ensureAdd(chicken);

      expect(chicken.velocity.y, equals(10));

      behavior.onCollisionStart({}, _MockGround());

      expect(chicken.velocity.y, equals(0));
    });

    flameTester.test('not on the ground when the collision end', (game) async {
      final behavior = GroundCollidingBehavior();
      final chicken = Chicken.test(
        velocity: Vector2(0, 10),
        behavior: behavior,
      );

      await game.ready();
      await game.ensureAdd(chicken);

      expect(chicken.onGround, isTrue);

      behavior.onCollisionEnd(_MockGround());

      expect(chicken.onGround, isFalse);
    });
  });
}
