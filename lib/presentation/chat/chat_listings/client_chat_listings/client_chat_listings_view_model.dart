import 'dart:developer';

import 'package:dating_app/domain/model/chat_room_listing.dart';
import 'package:dating_app/domain/repository/in_chat_repository.dart';
import 'package:flutter/material.dart';

class ClientChatListingsViewModel extends ChangeNotifier {
  final ChatRepository _repository;

  // final AuthRepository _authRepository;

  final String? myId;

  late Stream<List<ChatRoomListing>> _stream;

  ClientChatListingsViewModel(this._repository, this.myId) {
    getChatRoomListing();
  }

  Stream<List<ChatRoomListing>> get stream => _stream;

  // void onEvent(MessagesEvent event) {
  //   event.when(
  //     getMessages: _getMessages,
  //   );
  // }

  void getChatRoomListing() {

    final result = _repository.getChatRoomListings(myId!);
    result.when(
      success: (stream) {
        _stream = stream;
      },
      error: (errorMessage) {
        log(errorMessage);
      },
    );
  }
}
