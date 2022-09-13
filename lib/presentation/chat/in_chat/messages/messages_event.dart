import 'package:freezed_annotation/freezed_annotation.dart';

part 'messages_event.freezed.dart';

@freezed
abstract class MessagesEvent with _$MessagesEvent {
  const factory MessagesEvent.getMessages(String myId, String opponentId) = GetMessages;
}