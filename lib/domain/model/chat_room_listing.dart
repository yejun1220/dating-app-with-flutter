import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_room_listing.freezed.dart';
part 'chat_room_listing.g.dart';

@freezed
class ChatRoomListing with _$ChatRoomListing {
  factory ChatRoomListing({
    required String opponentId,
    required String imageUrl,
    required String title,
    required String area,
    required String content,
    required int timestamp,
  }) = _ChatRoomListing;
  factory ChatRoomListing.fromJson(Map<String, dynamic> json) => _$ChatRoomListingFromJson(json);
}
