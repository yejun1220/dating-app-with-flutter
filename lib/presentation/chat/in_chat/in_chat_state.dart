import 'package:freezed_annotation/freezed_annotation.dart';

part 'in_chat_state.freezed.dart';
part 'in_chat_state.g.dart';

@freezed
class InChatState with _$InChatState {
  const factory InChatState({
    @Default('') String opponentId,
    @Default('') String opponentName,
    @Default('') String opponentImageUrl,
    @Default('') String opponentArea,
    @Default(1) int myRole,
    @Default('') String message,

  }) = _InChatState;

  factory InChatState.fromJson(Map<String, Object?> json) => _$InChatStateFromJson(json);
}