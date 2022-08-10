import 'package:chicken_game/bootstrap.dart';
import 'package:chicken_game/game/game.dart';
import 'package:flame/game.dart';

void main() {
  bootstrap(() => GameWidget(game: ChickenGame()));
}
