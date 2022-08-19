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

    flameTester.test('detects when bottom touches', (game) async {
      final chicken = Chicken.test(
        center: Vector2(0, 0),
        behavior: groundCollidingBehavior,
      );

      await game.ready();
      await game.ensureAdd(chicken);
      chicken.isBottomTouching = false;

      groundCollidingBehavior
          .onCollision({Vector2(0, 0), Vector2(10, 10)}, _MockGround());

      expect(chicken.isBottomTouching, isTrue);
    });

    flameTester.test('detects when top touches', (game) async {
      final chicken = Chicken.test(
        center: Vector2(0, 200),
        behavior: groundCollidingBehavior,
      );

      await game.ready();
      await game.ensureAdd(chicken);

      expect(chicken.isTopTouching, isFalse);

      groundCollidingBehavior
          .onCollision({Vector2(0, 0), Vector2(10, 0)}, _MockGround());

      expect(chicken.isTopTouching, isTrue);
    });

    flameTester.test('detects when side(right) touches', (game) async {
      final chicken = Chicken.test(
        center: Vector2(10, 0),
        behavior: groundCollidingBehavior,
      );

      await game.ready();
      await game.ensureAdd(chicken);

      expect(chicken.isLeftSideTouching, isFalse);
      expect(chicken.isRightSideTouching, isFalse);

      groundCollidingBehavior
          .onCollision({Vector2(11, 0), Vector2(12, 10)}, _MockGround());

      expect(chicken.isLeftSideTouching, isFalse);
      expect(chicken.isRightSideTouching, isTrue);
    });

    flameTester.test('detects when side(left) touches', (game) async {
      final chicken = Chicken.test(
        center: Vector2(10, 0),
        behavior: groundCollidingBehavior,
      );

      await game.ready();
      await game.ensureAdd(chicken);

      expect(chicken.isLeftSideTouching, isFalse);
      expect(chicken.isRightSideTouching, isFalse);

      chicken.isFlipped = false;
      groundCollidingBehavior
          .onCollision({Vector2(8, 0), Vector2(9, 10)}, _MockGround());

      expect(chicken.isLeftSideTouching, isTrue);
      expect(chicken.isRightSideTouching, isFalse);
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
