import 'package:chicken_game/entities/entities.dart';
import 'package:chicken_game/game/game.dart';
import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flutter/services.dart';

class KeyboardMovingBehavior extends Behavior<Chicken>
    with KeyboardHandler, HasGameRef<ChickenGame> {
  KeyboardMovingBehavior({
    required this.jumpKey,
    required this.leftKey,
    required this.rightKey,
  });

  final LogicalKeyboardKey jumpKey;
  final LogicalKeyboardKey leftKey;
  final LogicalKeyboardKey rightKey;

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    _setVelocityX(keysPressed);
    _setVelocityY(keysPressed);

    return super.onKeyEvent(event, keysPressed);
  }

  void _setVelocityX(Set<LogicalKeyboardKey> keysPressed) {
    if (keysPressed.contains(leftKey) && !parent.isLeftSideTouching) {
      parent.isWalking = true;
      parent.velocity.x = -120;
    } else if (keysPressed.contains(rightKey) && !parent.isRightSideTouching) {
      parent.isWalking = true;
      parent.velocity.x = 120;
    } else {
      parent.isWalking = false;
    }
  }

  void _setVelocityY(Set<LogicalKeyboardKey> keysPressed) {
    if (!keysPressed.contains(jumpKey)) return;
    if (parent.velocity.y != 0) return;
    if (parent.isTopTouching) return;

    parent.velocity.y -= 110;
  }

  @override
  void update(double dt) {
    _updateChickenDirection();
    _updateChickenState();

    super.update(dt);
  }

  void _updateChickenDirection() {
    if (parent.velocity.x > 0 && !parent.isFlipped) {
      parent
        ..isFlipped = true
        ..flipHorizontallyAroundCenter();
    }

    if (parent.velocity.x < 0 && parent.isFlipped) {
      parent
        ..isFlipped = false
        ..flipHorizontallyAroundCenter();
    }
  }

  void _updateChickenState() {
    if (parent.velocity.x == 0) {
      parent.updateState(state: const ChickenState.idle());
    } else {
      parent.updateState(state: const ChickenState.walking());
    }
  }
}
