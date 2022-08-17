import 'package:chicken_game/entities/entities.dart';
import 'package:chicken_game/game/game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flutter/services.dart';

class Chicken extends Entity with HasGameRef<ChickenGame> {
  Chicken({
    Vector2? center,
    required LogicalKeyboardKey upKey,
    required LogicalKeyboardKey downKey,
    required LogicalKeyboardKey leftKey,
    required LogicalKeyboardKey rightKey,
  }) : this._(
          center: center ?? Vector2(20, 575),
          behaviors: [
            ChickenGravityBehavior(),
            GroundCollidingBehavior(),
            KeyboardMovingBehavior(
              upKey: upKey,
              downKey: downKey,
              leftKey: leftKey,
              rightKey: rightKey,
            ),
          ],
          chickenSprite: ChickenSprite(textureSize: _chickenSize)
            ..size = _chickenSize,
        );

  Chicken._({
    required Vector2 center,
    required Iterable<Behavior> behaviors,
    required ChickenSprite chickenSprite,
  })  : _chickenSprite = chickenSprite,
        velocity = Vector2.zero(),
        super(
          size: _chickenSize,
          position: center,
          anchor: Anchor.center,
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
          upKey: LogicalKeyboardKey.keyW,
          downKey: LogicalKeyboardKey.keyS,
          leftKey: LogicalKeyboardKey.keyA,
          rightKey: LogicalKeyboardKey.keyD,
        );

  Chicken.arrows({
    Vector2? center,
  }) : this(
          center: center,
          upKey: LogicalKeyboardKey.arrowUp,
          downKey: LogicalKeyboardKey.arrowDown,
          leftKey: LogicalKeyboardKey.arrowLeft,
          rightKey: LogicalKeyboardKey.arrowRight,
        );

  final ChickenSprite _chickenSprite;
  final Vector2 velocity;
  bool onGround = true;
  bool isFlipped = false;

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
