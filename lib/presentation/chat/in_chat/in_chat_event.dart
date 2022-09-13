import 'package:freezed_annotation/freezed_annotation.dart';

part 'in_chat_event.freezed.dart';

@freezed
abstract class InChatEvent with _$InChatEvent {
  const factory InChatEvent.sendMessage(String to, String from, String message, String type) = SendMessage;
}