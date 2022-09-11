import 'package:dating_app/domain/model/freeboard_info.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_edit_freeboard_state.freezed.dart';
part 'post_edit_freeboard_state.g.dart';

@freezed
class PostEditFreeBoardState with _$PostEditFreeBoardState {
  const factory PostEditFreeBoardState({
    FreeBoardInfo? freeBoardInfo,
  }) = _PostEditFreeBoardState;

  factory PostEditFreeBoardState.fromJson(Map<String, Object?> json) => _$PostEditFreeBoardStateFromJson(json);
}