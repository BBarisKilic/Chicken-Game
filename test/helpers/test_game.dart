import 'package:chicken_game/game/game.dart';

class TestGame extends ChickenGame {
  TestGame() : super();

  @override
  Future<void>? onLoad() async {
    final futures = preLoadAssets().map((loadableBuilder) => loadableBuilder());
    await Future.wait<void>(futures);
    return super.onLoad();
  }
}
