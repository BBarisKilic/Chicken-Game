import 'package:chicken_game/components/components.dart';
import 'package:chicken_game/entities/chicken/chicken.dart';
import 'package:flame/extensions.dart';
import 'package:flame_behaviors/flame_behaviors.dart';

class GroundCollidingBehavior extends CollisionBehavior<Ground, Chicken> {
  @override
  void onCollision(Set<Vector2> intersectionPoints, Ground other) {
    final pointOne = intersectionPoints.first;
    final pointTwo = intersectionPoints.last;

    if ((pointOne.x - pointTwo.x).abs() < 2) {
      _onSideCollision(pointOne.x, pointTwo.x);
    } else {
      if ((parent.position.y - pointOne.y).abs() < parent.size.y / 2) {
        _onBottomCollision();
      } else {
        _onTopCollision();
      }
    }

    super.onCollision(intersectionPoints, other);
  }

  void _onSideCollision(double x1, double x2) {
    if (parent.isFlipped && parent.position.x < x1) {
      parent
        ..velocity.x = 0
        ..isBottomTouching = false
        ..isRightSideTouching = true;
    }

    if (!parent.isFlipped && parent.position.x > x1) {
      parent
        ..velocity.x = 0
        ..isBottomTouching = false
        ..isLeftSideTouching = true;
    }
  }

  void _onBottomCollision() {
    parent.velocity.y = 0;
    parent.isBottomTouching = true;
  }

  void _onTopCollision() {
    parent.velocity.y = 100;
    parent.isTopTouching = true;
  }

  @override
  void onCollisionEnd(Ground other) {
    parent
      ..isBottomTouching = false
      ..isTopTouching = false
      ..isLeftSideTouching = false
      ..isRightSideTouching = false;

    super.onCollisionEnd(other);
  }
}
