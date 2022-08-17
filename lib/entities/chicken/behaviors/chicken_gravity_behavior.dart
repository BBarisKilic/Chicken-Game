import 'package:chicken_game/entities/chicken/chicken.dart';
import 'package:flame_behaviors/flame_behaviors.dart';

class ChickenGravityBehavior extends Behavior<Chicken> {
  final gravity = 1.8;

  @override
  void update(double dt) {
    if (!parent.onGround) {
      parent.velocity.y += gravity;
      parent.y += parent.velocity.y * dt;
    }

    super.update(dt);
  }
}
