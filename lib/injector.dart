import 'package:chicken_game/assets_manager/assets_manager.dart';
import 'package:chicken_game/game/game.dart';
import 'package:get_it/get_it.dart';

final injector = GetIt.instance;

Future<void> initializeDependencies() async {
  injector
    ..registerLazySingleton<ChickenGame>(ChickenGame.new)
    ..registerFactory<AssetsManagerCubit>(
      () => AssetsManagerCubit(game: injector()),
    );
}
