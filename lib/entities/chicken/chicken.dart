import 'package:chicken_game/entities/entities.dart';
import 'package:chicken_game/game/game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Chicken extends Entity with HasGameRef<ChickenGame> {
  Chicken({
    Vector2? center,
    required LogicalKeyboardKey jumpKey,
    required LogicalKeyboardKey leftKey,
    required LogicalKeyboardKey rightKey,
  }) : this._(
          center: center ?? Vector2(30, 593),
          behaviors: [
            ChickenAirResistanceBehavior(),
            ChickenGravityBehavior(),
            GroundCollidingBehavior(),
            KeyboardMovingBehavior(
              jumpKey: jumpKey,
              leftKey: leftKey,
              rightKey: rightKey,
            ),
          ],
          chickenSprite: ChickenSprite(textureSize: _chickenSize)
            ..size = _chickenSize * 1.5,
        );

  Chicken._({
    Vector2? velocity,
    required Vector2 center,
    required Iterable<Behavior> behaviors,
    required ChickenSprite chickenSprite,
  })  : _chickenSprite = chickenSprite,
        velocity = velocity ?? Vector2.zero(),
        super(
          size: _chickenSize * 1.5,
          position: center,
          anchor: Anchor.bottomCenter,
          behaviors: [
            PropagatingCollisionBehavior(RectangleHitbox()),
            ...behaviors,
          ],
          children: [
            chickenSprite,
          ],
        );

  Chicken.wasd({
    Vector2? center,
  }) : this(
          center: center,
          jumpKey: LogicalKeyboardKey.keyW,
          leftKey: LogicalKeyboardKey.keyA,
          rightKey: LogicalKeyboardKey.keyD,
        );

  Chicken.arrows({
    Vector2? center,
  }) : this(
          center: center,
          jumpKey: LogicalKeyboardKey.arrowUp,
          leftKey: LogicalKeyboardKey.arrowLeft,
          rightKey: LogicalKeyboardKey.arrowRight,
        );

  @visibleForTesting
  Chicken.test({
    Vector2? velocity,
    Vector2? center,
    Behavior? behavior,
  }) : this._(
          velocity: velocity,
          center: center ?? Vector2(30, 593),
          behaviors: [if (behavior != null) behavior],
          chickenSprite: ChickenSprite(textureSize: _chickenSize)
            ..size = _chickenSize,
        );

  final ChickenSprite _chickenSprite;
  final Vector2 velocity;
  bool isBottomTouching = true;
  bool isTopTouching = false;
  bool isLeftSideTouching = false;
  bool isRightSideTouching = false;
  bool isFlipped = false;
  bool isWalking = false;

  @override
  Future<void>? onLoad() {
    flipHorizontallyAroundCenter();
    isFlipped = true;

    return super.onLoad();
  }

  void updateState({required ChickenState state}) =>
      _chickenSprite.updateState(state: state);

  static final _chickenSize = Vector2(32, 34);
}
