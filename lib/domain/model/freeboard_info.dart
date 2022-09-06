import 'package:freezed_annotation/freezed_annotation.dart';

part 'freeboard_info.freezed.dart';
part 'freeboard_info.g.dart';

@freezed
class FreeBoardInfo with _$FreeBoardInfo {
  const factory FreeBoardInfo({
    String? id,
    required String title,
    required String content,
    required String userName,
    required List<String> isPressedList,
    required int timestamp,
    required int comments,
  }) = _FreeBoardInfo;

  factory FreeBoardInfo.fromJson(Map<String, dynamic> json) => _$FreeBoardInfoFromJson(json);
}
