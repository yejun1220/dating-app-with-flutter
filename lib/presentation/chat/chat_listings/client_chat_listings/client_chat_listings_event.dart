import 'package:freezed_annotation/freezed_annotation.dart';

part 'client_chat_listings_event.freezed.dart';

@freezed
abstract class ClientChatListingsEvent with _$ClientChatListingsEvent {
  const factory ClientChatListingsEvent.leave() = Leave;
  const factory ClientChatListingsEvent.pin() = Pin;
}