import 'dart:developer';

import 'package:dating_app/domain/model/message_info.dart';
import 'package:dating_app/domain/repository/in_chat_repository.dart';
import 'package:dating_app/presentation/chat/in_chat/messages/messages_event.dart';
import 'package:flutter/material.dart';

class MessagesViewModel extends ChangeNotifier {
  final ChatRepository _repository;

  late Stream<List<MessageInfo>> _stream;

  MessagesViewModel(this._repository);

  Stream<List<MessageInfo>> get stream => _stream;

  void onEvent(MessagesEvent event) {
    event.when(
      getMessages: _getMessages,
    );
  }

  void _getMessages(String myId, String opponentId) {
    final result = _repository.getMessages(myId, opponentId);
    result.when(
      success: (stream) {
        _stream = stream;
      },
      error: (e) {
        log(e);
      },
    );
  }
}
