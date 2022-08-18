// ignore_for_file: cascade_invocations

import 'package:chicken_game/entities/entities.dart';
import 'package:flame/game.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/helpers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ChickenGravityBehavior', () {
    final flameTester = FlameTester<TestGame>(TestGame.new);

    flameTester.test('gravity works as expected', (game) async {
      final centerY = game.size.y / 2;
      final chicken = Chicken.wasd(center: Vector2(0, centerY));

      await game.ready();
      await game.ensureAdd(chicken);

      chicken.onGround = false;
      game.update(1);

      expect(chicken.position.y, isNot(equals(centerY)));
    });
  });
}
