// ignore_for_file: cascade_invocations

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
      jumpKey: LogicalKeyboardKey.arrowUp,
      leftKey: LogicalKeyboardKey.arrowLeft,
      rightKey: LogicalKeyboardKey.arrowRight,
    );
  });

  group('KeyboardMovingBehavior', () {
    final flameTester = FlameTester<TestGame>(TestGame.new);

    group('initial', () {
      test('keys are correct', () {
        expect(
          keyboardMovingBehavior.jumpKey,
          equals(LogicalKeyboardKey.arrowUp),
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

    flameTester.test('jumps as expected', (game) async {
      final chicken = Chicken.test(
        behavior: keyboardMovingBehavior,
      );

      await game.ready();
      await game.ensureAdd(chicken);

      final event = _RawKeyEvent();
      final keysPressed = {LogicalKeyboardKey.arrowUp};

      expect(chicken.velocity.y, equals(0));

      keyboardMovingBehavior.onKeyEvent(event, keysPressed);

      expect(chicken.velocity.y, equals(-110));
    });

    flameTester.test('moves right as expected', (game) async {
      final chicken = Chicken.test(
        behavior: keyboardMovingBehavior,
      );

      await game.ready();
      await game.ensureAdd(chicken);

      final event = _RawKeyEvent();
      final keysPressed = {LogicalKeyboardKey.arrowRight};

      expect(chicken.velocity.x, equals(0));

      keyboardMovingBehavior.onKeyEvent(event, keysPressed);

      expect(chicken.velocity.x, equals(120));
    });

    flameTester.test('moves left as expected', (game) async {
      final chicken = Chicken.test(
        behavior: keyboardMovingBehavior,
      );

      await game.ready();
      await game.ensureAdd(chicken);

      final event = _RawKeyEvent();
      final keysPressed = {LogicalKeyboardKey.arrowLeft};

      expect(chicken.velocity.x, equals(0));

      keyboardMovingBehavior.onKeyEvent(event, keysPressed);

      expect(chicken.velocity.x, equals(-120));
    });

    flameTester.test('flips as expected', (game) async {
      final chicken = Chicken.test(
        behavior: keyboardMovingBehavior,
      );

      await game.ready();
      await game.ensureAdd(chicken);

      final event = _RawKeyEvent();
      final leftKeysPressed = {LogicalKeyboardKey.arrowLeft};
      final rightKeysPressed = {LogicalKeyboardKey.arrowRight};

      keyboardMovingBehavior.onKeyEvent(event, leftKeysPressed);
      game.update(1);

      expect(chicken.isFlipped, isFalse);

      keyboardMovingBehavior.onKeyEvent(event, rightKeysPressed);
      game.update(1);

      expect(chicken.isFlipped, isTrue);
    });

    flameTester.test('motionless as expected', (game) async {
      final chicken = Chicken.test(
        behavior: keyboardMovingBehavior,
      );

      await game.ready();
      await game.ensureAdd(chicken);

      final event = _RawKeyEvent();
      final keysPressed = <LogicalKeyboardKey>{};

      keyboardMovingBehavior.onKeyEvent(event, keysPressed);

      expect(chicken.velocity, equals(Vector2.zero()));
    });

    flameTester.test('key events are handled', (game) {
      final event = _RawKeyEvent();
      final keysPressed = {LogicalKeyboardKey.pageDown};

      expect(game.onKeyEvent(event, keysPressed), KeyEventResult.handled);
    });
  });
}
