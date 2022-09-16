import 'package:dating_app/domain/model/chat_room_listing.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'client_chat_listings_state.freezed.dart';
part 'client_chat_listings_state.g.dart';

@freezed
class ClientChatListingsState with _$ClientChatListingsState {
  const factory ClientChatListingsState({
    @Default([]) List<ChatRoomListing> chatRooms,

  }) = _ClientChatListingsState;

  factory ClientChatListingsState.fromJson(Map<String, Object?> json) => _$ClientChatListingsStateFromJson(json);
}