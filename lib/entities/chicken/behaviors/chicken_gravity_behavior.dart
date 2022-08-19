import 'package:chicken_game/entities/chicken/chicken.dart';
import 'package:flame_behaviors/flame_behaviors.dart';

const kGravity = 80;

class ChickenGravityBehavior extends Behavior<Chicken> {
  @override
  void update(double dt) {
    _applyGravity(dt);
    _setPositionY(dt);

    super.update(dt);
  }

  void _applyGravity(double dt) {
    if (parent.velocity.y > 0 || !parent.isBottomTouching) {
      parent.velocity.y += kGravity * dt;
    }
  }

  void _setPositionY(double dt) {
    parent.position.y += parent.velocity.y * dt;
  }
}
