import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chicken_game/game/game.dart';
import 'package:equatable/equatable.dart';

part 'assets_manager_state.dart';

class AssetsManagerCubit extends Cubit<AssetsManagerState> {
  AssetsManagerCubit({
    required ChickenGame game,
  })  : _game = game,
        super(const AssetsManagerState.initial());

  final ChickenGame _game;
  final _loadables = <Future<void> Function()>[];

  Future<void> load() async {
    await Future<void>.delayed(const Duration(seconds: 1));

    _loadables.addAll(_game.preLoadAssets());

    emit(state.copyWith(assetsCount: _loadables.length));

    unawaited(_triggerLoad());
  }

  Future<void> _triggerLoad() async {
    if (_loadables.isEmpty) return;

    final loadable = _loadables.removeAt(0);
    await loadable();

    unawaited(_triggerLoad());

    emit(state.copyWith(loaded: state.loaded + 1));
  }
}
