import 'package:chicken_game/game/game.dart';
import 'package:flame/extensions.dart';

extension ChickenGameAssetsX on ChickenGame {
  List<Future<Image> Function()> preLoadAssets() {
    return [
      () => images.load('chicken_idle.png'),
      () => images.load('chicken_walking.png'),
    ];
  }
}
