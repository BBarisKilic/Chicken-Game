import 'package:chicken_game/game/game.dart';

class TestGame extends ChickenGame {
  TestGame() : super();

  @override
  Future<void>? onLoad() async {
    final futures = [
      ...preLoadAssets(),
    ];

    await Future.wait<void>(
      futures.map((loadableBuilder) => loadableBuilder()).toList(),
    );

    return super.onLoad();
  }
}
