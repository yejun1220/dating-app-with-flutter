import 'package:dating_app/data/data_source/firebase_api.dart';
import 'package:dating_app/domain/model/chat_room_listing.dart';
import 'package:dating_app/domain/model/message_info.dart';
import 'package:dating_app/domain/repository/in_chat_repository.dart';
import 'package:dating_app/util/result.dart';

class ChatRepositoryImpl implements ChatRepository {
  final FirebaseApi _firebaseApi;

  ChatRepositoryImpl(this._firebaseApi);

  @override
  Result<Stream<List<MessageInfo>>> getMessages(String myId, String opponentId) {
    final result = _firebaseApi.getMessages(myId, opponentId);
    return Result.success(result);
  }

  @override
  Future<Result<void>> sendMessage(MessageInfo messageInfo, ChatRoomListing chatRoomListing) async {
    try {
      final result = await _firebaseApi.sendMessage(messageInfo, chatRoomListing);
      return Result.success(result);
    } catch (e) {
      return Result.error('메시지 전송 실패: $e');
    }
  }

  @override
  Result<Stream<List<ChatRoomListing>>> getChatRoomListings(String myId) {
    try {
      final result = _firebaseApi.getChatRoomListings(myId);
      return Result.success(result);
    } catch (e) {
      return Result.error('채팅방 가져오기 실패: $e');
    }
  }


}