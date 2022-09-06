import 'package:dating_app/domain/model/freeboard_info.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'freeboard_info_state.freezed.dart';

part 'freeboard_info_state.g.dart';

@freezed
class FreeBoardInfoState with _$FreeBoardInfoState {
  const factory FreeBoardInfoState({
    FreeBoardInfo? freeBoardInfo,
    @Default(false) bool isLoading,
  }) = _FreeBoardInfoState;

  factory FreeBoardInfoState.fromJson(Map<String, Object?> json) => _$FreeBoardInfoStateFromJson(json);
}