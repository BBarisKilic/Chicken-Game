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

  late GroundCollidingBehavior groundCollidingBehavior;

  setUp(() {
    groundCollidingBehavior = GroundCollidingBehavior();
  });

  group('GroundCollidingBehavior', () {
    final flameTester = FlameTester<TestGame>(TestGame.new);

    flameTester.test('stops when the collision start', (game) async {
      final chicken = Chicken.test(
        velocity: Vector2(0, 10),
        center: Vector2(0, 0),
        behavior: groundCollidingBehavior,
      );

      await game.ready();
      await game.ensureAdd(chicken);

      expect(chicken.velocity.y, equals(10));

      groundCollidingBehavior
          .onCollision({Vector2(0, 0), Vector2(10, 10)}, _MockGround());

      expect(chicken.velocity.y, equals(0));
    });

    flameTester.test('bottom is not touching when the collision end',
        (game) async {
      final chicken = Chicken.test(
        velocity: Vector2(0, 10),
        behavior: groundCollidingBehavior,
      );

      await game.ready();
      await game.ensureAdd(chicken);

      expect(chicken.isBottomTouching, isTrue);

      groundCollidingBehavior.onCollisionEnd(_MockGround());

      expect(chicken.isBottomTouching, isFalse);
    });
  });
}
