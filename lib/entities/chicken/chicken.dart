import 'package:chicken_game/components/components.dart';
import 'package:chicken_game/entities/chicken/behaviors/behaviors.dart';
import 'package:chicken_game/entities/chicken/states/states.dart';
import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flutter/services.dart';

class Chicken extends Entity {
  Chicken({
    Vector2? center,
    required LogicalKeyboardKey upKey,
    required LogicalKeyboardKey downKey,
    required LogicalKeyboardKey leftKey,
    required LogicalKeyboardKey rightKey,
  }) : this._(
          center: center ?? Vector2.all(200),
          movingBehavior: KeyboardMovingBehavior(
            upKey: upKey,
            downKey: downKey,
            leftKey: leftKey,
            rightKey: rightKey,
          ),
          chickenSpriteComponent:
              ChickenSpriteComponent(textureSize: _chickenSize)
                ..size = _chickenScaleFactor,
        );

  Chicken._({
    required Vector2 center,
    required Behavior movingBehavior,
    required ChickenSpriteComponent chickenSpriteComponent,
  })  : _chickenSpriteComponent = chickenSpriteComponent,
        super(
          position: center,
          anchor: Anchor.center,
          behaviors: [movingBehavior],
          children: [chickenSpriteComponent],
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

  final ChickenSpriteComponent _chickenSpriteComponent;

  void updateState({required ChickenState state}) =>
      _chickenSpriteComponent.updateState(state: state);

  static final _chickenSize = Vector2(32, 34);
  static final _chickenScaleFactor = _chickenSize * 2.0;
}
