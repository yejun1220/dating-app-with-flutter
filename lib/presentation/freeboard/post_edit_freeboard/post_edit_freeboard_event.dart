import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_edit_freeboard_event.freezed.dart';

@freezed
abstract class PostEditFreeBoardEvent with _$PostEditFreeBoardEvent {
  const factory PostEditFreeBoardEvent.saveFreeBoard(String? id, String title, String content, String userName) = SaveFreeBoard;
}