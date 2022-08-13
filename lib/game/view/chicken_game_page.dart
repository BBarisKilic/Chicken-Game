import 'package:chicken_game/assets_manager/assets_manager.dart';
import 'package:chicken_game/game/game.dart';
import 'package:chicken_game/injector.dart' as di;
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChickenGamePage extends StatelessWidget {
  const ChickenGamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AssetsManagerCubit, AssetsManagerState>(
      builder: (context, state) {
        return state.isLoading
            ? LoadingPage(progress: state.progress)
            : const ChickenGameLoadedView();
      },
    );
  }
}

class ChickenGameLoadedView extends StatelessWidget {
  const ChickenGameLoadedView({super.key});

  @override
  Widget build(BuildContext context) {
    return GameWidget<ChickenGame>(game: di.injector<ChickenGame>());
  }
}
