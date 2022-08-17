import 'package:chicken_game/entities/entities.dart';
import 'package:chicken_game/game/game.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';

class ChickenSprite extends SpriteAnimationGroupComponent<ChickenState>
    with HasGameRef<ChickenGame> {
  ChickenSprite({
    ChickenState state = const ChickenState.idle(),
    required Vector2 textureSize,
  })
      : _state = state,
        _textureSize = textureSize,
        super();

  final ChickenState _state;
  final Vector2 _textureSize;
  final int number = 10;

  @override
  Future<void>? onLoad() async {
    final idleImage = Flame.images.fromCache('chicken_idle.png');
    final walkingImage = Flame.images.fromCache('chicken_walking.png');

    final idle = SpriteAnimation.fromFrameData(
      idleImage,
      SpriteAnimationData.sequenced(
        amount: 13,
        stepTime: 0.1,
        textureSize: _textureSize,
      ),
    );

    final walking = SpriteAnimation.fromFrameData(
      walkingImage,
      SpriteAnimationData.sequenced(
        amount: 14,
        stepTime: 0.07,
        textureSize: _textureSize,
      ),
    );

    animations = {
      const ChickenState.idle(): idle,
      const ChickenState.walking(): walking
    };

    current = _state;


    return super.onLoad();
  }

  void updateState({required ChickenState state}) {
    if (current != state) current = state;
  }
}
