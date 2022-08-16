import 'package:chicken_game/entities/entities.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChickenGame extends FlameGame with HasKeyboardHandlerComponents {
  @override
  Future<void>? onLoad() async {
    final map = await TiledComponent.load('level_1.tmx', Vector2(16, 16));

    final mapHeight = 16.0 * map.tileMap.map.height;
    final mapWidth = 16.0 * map.tileMap.map.width;

    camera.viewport = FixedResolutionViewport(Vector2(mapWidth, mapHeight));

    await add(map);

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
