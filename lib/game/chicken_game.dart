import 'package:chicken_game/entities/entities.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChickenGame extends FlameGame with HasKeyboardHandlerComponents {
  @override
  Future<void>? onLoad() async {
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
