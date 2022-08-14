// ignore_for_file: cascade_invocations

import 'package:chicken_game/components/components.dart';
import 'package:chicken_game/entities/chicken/behaviors/behaviors.dart';
import 'package:chicken_game/entities/entities.dart';
import 'package:chicken_game/game/game.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/helpers.dart';

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

  group('ChickenGame', () {
    final flameTester = FlameTester<TestGame>(TestGame.new);

    test('can be instantiated', () {
      expect(ChickenGame(), isA<ChickenGame>());
    });

    group('components', () {
      flameTester.test('has only one ChickenSpriteComponent', (game) async {
        await game.ready();

        expect(
          game.descendants().whereType<ChickenSpriteComponent>().length,
          equals(1),
        );
      });
    });

    group('entities', () {
      flameTester.test('has only one Chicken', (game) async {
        await game.ready();

        expect(
          game.children.whereType<Chicken>().length,
          equals(1),
        );
      });
    });

    group('behaviors', () {
      flameTester.test('Chicken has KeyboardMovingBehavior', (game) async {
        await game.ready();

        final chicken = game.children.whereType<Chicken>();

        expect(
          chicken.first.hasBehavior<KeyboardMovingBehavior>(),
          isTrue,
        );
      });
    });

    group('key events', () {
      flameTester.test('are handled', (game) async {
        await game.ready();

        final event = _RawKeyEvent();
        final keysPressed = {LogicalKeyboardKey.pageDown};

        expect(
          game.onKeyEvent(event, keysPressed),
          KeyEventResult.handled,
        );
      });

      flameTester.test('pressed down arrow', (game) async {
        await game.ready();

        final keysPressed = {LogicalKeyboardKey.arrowDown};

        expect(
          keysPressed.contains(LogicalKeyboardKey.arrowDown),
          isTrue,
        );
      });
    });
  });
}
