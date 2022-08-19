import 'package:chicken_game/entities/entities.dart';
import 'package:flame_behaviors/flame_behaviors.dart';

const kAirResistance = 120;

class ChickenAirResistanceBehavior extends Behavior<Chicken> {
  @override
  void update(double dt) {
    _applyAirResistance(dt);
    _setPositionX(dt);

    super.update(dt);
  }

  void _applyAirResistance(double dt) {
    if (parent.isWalking) return;

    if (parent.velocity.x > 0) {
      parent.velocity.x -= kAirResistance * dt;

      if (parent.velocity.x <= 1) parent.velocity.x = 0;
    }

    if (parent.velocity.x < 0) {
      parent.velocity.x += kAirResistance * dt;

      if (parent.velocity.x >= -1) parent.velocity.x = 0;
    }
  }

  void _setPositionX(double dt) {
    parent.position.x += parent.velocity.x * dt;
  }
}
