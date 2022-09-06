import 'package:freezed_annotation/freezed_annotation.dart';

part 'freeboard_info_ui_event.freezed.dart';

@freezed
abstract class FreeBoardInfoUiEvent with _$FreeBoardInfoUiEvent {
  const factory FreeBoardInfoUiEvent.deleteFreeBoard() = DeleteFreeBoard;
}