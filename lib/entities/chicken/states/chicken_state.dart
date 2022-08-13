import 'package:freezed_annotation/freezed_annotation.dart';

part 'chicken_state.freezed.dart';

@freezed
abstract class ChickenState with _$ChickenState {
  const factory ChickenState.idle() = _Idle;
  const factory ChickenState.walking() = _Walking;
}
