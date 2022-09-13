import 'package:dating_app/domain/model/chat_room_listing.dart';
import 'package:dating_app/domain/model/message_info.dart';
import 'package:dating_app/domain/repository/in_chat_repository.dart';
import 'package:dating_app/presentation/chat/in_chat/in_chat_event.dart';
import 'package:dating_app/presentation/chat/in_chat/in_chat_state.dart';
import 'package:flutter/material.dart';

class InChatViewModel extends ChangeNotifier {
  final ChatRepository _repository;

  var _state = const InChatState();

  InChatState get state => _state;

  InChatViewModel(this._repository, String opponentId, String opponentName, String opponentImageUrl, String opponentArea) {
    _state = _state.copyWith(
      opponentId: opponentId,
      opponentName: opponentName,
      opponentImageUrl: opponentImageUrl,
      opponentArea: opponentArea,
    );
  }

  void onEvent(InChatEvent event) {
    event.when(
      sendMessage: _sendMessage,
    );
  }

  Future<void> _sendMessage(String to, String from, String message, String type) async {
    await _repository.sendMessage(
      MessageInfo(
        opponentId: _state.opponentId,
        to: to,
        from: from,
        message: message,
        timestamp: DateTime.now().millisecondsSinceEpoch,
        type: type,
      ),
      ChatRoomListing(
        opponentId: _state.opponentId,
        imageUrl: _state.opponentImageUrl,
        title: _state.opponentName,
        area: _state.opponentArea,
        content: message,
        timestamp: DateTime.now().millisecondsSinceEpoch,
      ),
    );
  }

  void changedMessage(String message) {
    _state = _state.copyWith(
      message: message,
    );

    notifyListeners();
  }
}
