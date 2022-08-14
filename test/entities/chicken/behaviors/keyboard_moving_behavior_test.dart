// ignore_for_file: cascade_invocations

import 'package:chicken_game/entities/chicken/behaviors/behaviors.dart';
import 'package:chicken_game/entities/entities.dart';
import 'package:flame/extensions.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/helpers.dart';

mixin _DiagnosticableToStringMixin on Object {
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return super.toString();
  }
}

class _RawKeyEvent extends Mock
    with _DiagnosticableToStringMixin
    implements RawKeyEvent {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late KeyboardMovingBehavior keyboardMovingBehavior;

  setUp(() {
    keyboardMovingBehavior = KeyboardMovingBehavior(
      upKey: LogicalKeyboardKey.arrowUp,
      downKey: LogicalKeyboardKey.arrowDown,
      leftKey: LogicalKeyboardKey.arrowLeft,
      rightKey: LogicalKeyboardKey.arrowRight,
    );
  });

  group('KeyboardMovingBehavior', () {
    final flameTester = FlameTester<TestGame>(TestGame.new);
    const speed = 100;

    group('initial', () {
      test('speed is 100', () {
        expect(keyboardMovingBehavior.speed, equals(100));
      });

      test('keys are correct', () {
        expect(
          keyboardMovingBehavior.upKey,
          equals(LogicalKeyboardKey.arrowUp),
        );
        expect(
          keyboardMovingBehavior.downKey,
          equals(LogicalKeyboardKey.arrowDown),
        );
        expect(
          keyboardMovingBehavior.leftKey,
          equals(LogicalKeyboardKey.arrowLeft),
        );
        expect(
          keyboardMovingBehavior.rightKey,
          equals(LogicalKeyboardKey.arrowRight),
        );
      });
    });

    flameTester.test('moves down as expected', (game) async {
      final centerY = game.size.y / 2;
      final chicken = Chicken.wasd(center: Vector2(0, centerY));

      await game.ready();
      await game.ensureAdd(chicken);

      final event = _RawKeyEvent();
      final keysPressed = {LogicalKeyboardKey.keyS};

      game.onKeyEvent(event, keysPressed);
      game.update(1);

      expect(chicken.position.y, equals(centerY + speed));
    });

    flameTester.test('moves up as expected', (game) async {
      final centerY = game.size.y / 2;
      final chicken = Chicken.arrows(center: Vector2(0, centerY));

      await game.ready();
      await game.ensureAdd(chicken);

      final event = _RawKeyEvent();
      final keysPressed = {LogicalKeyboardKey.arrowUp};

      game.onKeyEvent(event, keysPressed);
      game.update(1);

      expect(chicken.position.y, equals(centerY - speed));
    });

    flameTester.test('moves right as expected', (game) async {
      final centerX = game.size.x / 2;
      final chicken = Chicken.wasd(center: Vector2(centerX, 0));

      await game.ready();
      await game.ensureAdd(chicken);

      final event = _RawKeyEvent();
      final keysPressed = {LogicalKeyboardKey.keyD};

      game.onKeyEvent(event, keysPressed);
      game.update(1);

      expect(chicken.position.x, equals(centerX + speed));
    });

    flameTester.test('moves left as expected', (game) async {
      final centerX = game.size.x / 2;
      final chicken = Chicken.arrows(center: Vector2(centerX, 0));

      await game.ready();
      await game.ensureAdd(chicken);

      final event = _RawKeyEvent();
      final keysPressed = {LogicalKeyboardKey.arrowLeft};

      game.onKeyEvent(event, keysPressed);
      game.update(1);

      expect(chicken.position.x, equals(centerX - speed));
    });

    flameTester.test('flippes as expected', (game) async {
      final centerX = game.size.x / 2;
      final chicken = Chicken.arrows(center: Vector2(centerX, 0));

      await game.ready();
      await game.ensureAdd(chicken);

      final event = _RawKeyEvent();
      final rightKeysPressed = {LogicalKeyboardKey.arrowRight};
      final leftKeysPressed = {LogicalKeyboardKey.arrowLeft};

      game.onKeyEvent(event, rightKeysPressed);
      game.update(1);

      game.onKeyEvent(event, leftKeysPressed);
      game.update(2);

      expect(chicken.position.x, equals(centerX - speed));
    });

    flameTester.test('motionless as expected', (game) async {
      final centerY = game.size.y / 2;
      final chicken = Chicken.wasd(center: Vector2(0, centerY));

      await game.ready();
      await game.ensureAdd(chicken);

      final event = _RawKeyEvent();
      final keysPressed = <LogicalKeyboardKey>{};

      game.onKeyEvent(event, keysPressed);
      game.update(1);

      expect(chicken.position.y, equals(centerY));
    });

    flameTester.test('key events are handled', (game) {
      final event = _RawKeyEvent();
      final keysPressed = {LogicalKeyboardKey.pageDown};

      expect(game.onKeyEvent(event, keysPressed), KeyEventResult.handled);
    });
  });
}
