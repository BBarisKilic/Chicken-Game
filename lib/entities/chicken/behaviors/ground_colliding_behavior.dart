import 'package:chicken_game/components/components.dart';
import 'package:chicken_game/entities/chicken/chicken.dart';
import 'package:flame/extensions.dart';
import 'package:flame_behaviors/flame_behaviors.dart';

class GroundCollidingBehavior extends CollisionBehavior<Ground, Chicken> {
  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, Ground other) {
    parent.velocity.y = 0;
    parent.onGround = true;

    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  void onCollisionEnd(Ground other) {
    parent.onGround = false;
    super.onCollisionEnd(other);
  }
}
