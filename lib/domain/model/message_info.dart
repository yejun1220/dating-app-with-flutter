import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_info.freezed.dart';
part 'message_info.g.dart';

@freezed
class MessageInfo with _$MessageInfo {
  const factory MessageInfo({
    String? id,
    required String opponentId,
    required String to,
    required String from,
    required String message,
    required int timestamp,
    required String type,
  }) = _MessageInfo;

  factory MessageInfo.fromJson(Map<String, dynamic> json) => _$MessageInfoFromJson(json);
}
