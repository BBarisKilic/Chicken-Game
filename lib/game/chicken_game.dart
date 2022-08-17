import 'package:chicken_game/components/components.dart';
import 'package:chicken_game/entities/entities.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tiled/tiled.dart';

class ChickenGame extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {
  @override
  Future<void>? onLoad() async {
    final map = await TiledComponent.load('level_1.tmx', Vector2(16, 16));

    await add(map);

    final mapHeight = 16.0 * map.tileMap.map.height;
    final mapWidth = 16.0 * map.tileMap.map.width;
    camera.viewport = FixedResolutionViewport(Vector2(mapWidth, mapHeight));

    final obstacleGroup = map.tileMap.getLayer<ObjectGroup>('ground');
    if (obstacleGroup != null) {
      for (final obj in obstacleGroup.objects) {
        await add(
          Ground(
            size: Vector2(obj.width, obj.height),
            position: Vector2(obj.x, obj.y),
          ),
        );
      }
    }

    await add(Chicken.wasd());

    return super.onLoad();
  }

  @override
  @mustCallSuper
  KeyEventResult onKeyEvent(
    RawKeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    super.onKeyEvent(event, keysPressed);

    return KeyEventResult.handled;
  }
}
