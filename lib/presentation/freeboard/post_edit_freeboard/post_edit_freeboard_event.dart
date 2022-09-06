import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_edit_freeboard_event.freezed.dart';

@freezed
abstract class PostEditFreeboardEvent with _$PostEditFreeboardEvent {
  const factory PostEditFreeboardEvent.saveFreeboard(String? id, String title, String content) = SaveFreeboard;
}