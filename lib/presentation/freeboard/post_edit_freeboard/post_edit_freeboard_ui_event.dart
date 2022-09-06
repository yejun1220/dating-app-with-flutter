import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_edit_freeboard_ui_event.freezed.dart';

// viewModel에서 다시 screen으로 작업을 해야할 때 쓰인다.(Navigator.pop, SnackBar 등)
@freezed
abstract class PostEditFreeBoardUiEvent with _$PostEditFreeBoardUiEvent {
  const factory PostEditFreeBoardUiEvent.saveFreeBoard() = SaveFreeBoard;
  const factory PostEditFreeBoardUiEvent.showSnackBar(String message) = ShowSnackBar;
}