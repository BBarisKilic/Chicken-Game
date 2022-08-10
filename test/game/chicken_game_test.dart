import 'package:chicken_game/game/game.dart';
import 'package:flame/game.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('App', () {
    testWidgets('renders ChickenGame', (tester) async {
      await tester.pumpWidget(GameWidget(game: ChickenGame()));
    });
  });
}
