import 'package:dating_app/domain/model/chat_room_listing.dart';
import 'package:dating_app/domain/model/message_info.dart';
import 'package:dating_app/util/result.dart';

abstract class ChatRepository {
  Result<Stream<List<MessageInfo>>> getMessages(String myId, String opponentId);
  Future<Result<void>> sendMessage(MessageInfo messageInfo, ChatRoomListing chatRoomListing);
  Result<Stream<List<ChatRoomListing>>> getChatRoomListings(String myId);
}
