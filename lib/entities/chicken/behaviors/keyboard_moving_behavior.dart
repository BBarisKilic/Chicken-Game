import 'package:chicken_game/entities/entities.dart';
import 'package:chicken_game/game/game.dart';
import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flutter/services.dart';

class KeyboardMovingBehavior extends Behavior<Chicken>
    with KeyboardHandler, HasGameRef<ChickenGame> {
  KeyboardMovingBehavior({
    this.speed = 100,
    required this.upKey,
    required this.downKey,
    required this.leftKey,
    required this.rightKey,
  })  : _isFlipped = false,
        _movementX = 0,
        _movementY = 0;

  final double speed;
  final LogicalKeyboardKey upKey;
  final LogicalKeyboardKey downKey;
  final LogicalKeyboardKey leftKey;
  final LogicalKeyboardKey rightKey;
  bool _isFlipped;
  double _movementX;
  double _movementY;

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    _setMovementX(keysPressed);
    _setMovementY(keysPressed);

    return super.onKeyEvent(event, keysPressed);
  }

  void _setMovementX(Set<LogicalKeyboardKey> keysPressed) {
    if (keysPressed.contains(leftKey)) {
      _movementX = -1;
    } else if (keysPressed.contains(rightKey)) {
      _movementX = 1;
    } else {
      _movementX = 0;
    }
  }

  void _setMovementY(Set<LogicalKeyboardKey> keysPressed) {
    if (keysPressed.contains(upKey)) {
      _movementY = -1;
    } else if (keysPressed.contains(downKey)) {
      _movementY = 1;
    } else {
      _movementY = 0;
    }
  }

  @override
  void update(double dt) {
    _updateChickenPosition(dt);
    _updateChickenDirection();
    _updateChickenState();

    super.update(dt);
  }

  void _updateChickenPosition(double dt) {
    parent.position.y += _movementY * speed * dt;
    parent.position.x += _movementX * speed * dt;
  }

  void _updateChickenDirection() {
    if (_movementX > 0 && !_isFlipped) {
      _isFlipped = true;
      parent.flipHorizontallyAroundCenter();
    }

    if (_movementX < 0 && _isFlipped) {
      _isFlipped = false;
      parent.flipHorizontallyAroundCenter();
    }
  }

  void _updateChickenState() {
    if (_movementX == 0 && _movementY == 0) {
      parent.updateState(state: const ChickenState.idle());
    } else {
      parent.updateState(state: const ChickenState.walking());
    }
  }
}
