// ignore_for_file: cascade_invocations

import 'package:chicken_game/entities/entities.dart';
import 'package:flame/extensions.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/test_game.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late ChickenAirResistanceBehavior chickenAirResistanceBehavior;

  setUp(() {
    chickenAirResistanceBehavior = ChickenAirResistanceBehavior();
  });

  group('ChickenAirResistanceBehavior', () {
    final flameTester = FlameTester<TestGame>(TestGame.new);

    flameTester.test(
        'applies resistance when having positive velocity in the x direction',
        (game) {
      final chicken = Chicken.test(
        velocity: Vector2(10, 0),
        behavior: chickenAirResistanceBehavior,
      );

      game.ready();
      game.ensureAdd(chicken);

      expect(chicken.velocity.x, equals(10));

      chickenAirResistanceBehavior.update(1);

      expect(chicken.velocity.x, isNot(equals(10)));
    });

    flameTester.test(
        'applies resistance when having negative velocity in the x direction',
        (game) {
      final chicken = Chicken.test(
        velocity: Vector2(-10, 0),
        behavior: chickenAirResistanceBehavior,
      );

      game.ready();
      game.ensureAdd(chicken);

      expect(chicken.velocity.x, equals(-10));

      chickenAirResistanceBehavior.update(1);

      expect(chicken.velocity.x, isNot(equals(-10)));
    });
  });
}
