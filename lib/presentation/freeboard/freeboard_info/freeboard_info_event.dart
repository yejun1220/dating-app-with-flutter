import 'package:freezed_annotation/freezed_annotation.dart';

part 'freeboard_info_event.freezed.dart';

@freezed
abstract class FreeBoardInfoEvent with _$FreeBoardInfoEvent {
  const factory FreeBoardInfoEvent.loadFreeBoardInfo(String id) = LoadFreeBoardInfo;
  const factory FreeBoardInfoEvent.deleteFreeBoardInfo(String id) = DeleteFreeBoardInfo;
}