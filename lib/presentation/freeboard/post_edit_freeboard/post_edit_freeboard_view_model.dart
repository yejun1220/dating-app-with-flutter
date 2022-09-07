import 'dart:async';

import 'package:dating_app/domain/model/freeboard_info.dart';
import 'package:dating_app/domain/repository/freeboard_repository.dart';
import 'package:dating_app/presentation/freeboard/post_edit_freeboard/post_edit_freeboard_event.dart';
import 'package:dating_app/presentation/freeboard/post_edit_freeboard/post_edit_freeboard_state.dart';
import 'package:dating_app/presentation/freeboard/post_edit_freeboard/post_edit_freeboard_ui_event.dart';
import 'package:flutter/material.dart';

class PostEditFreeBoardViewModel with ChangeNotifier {
  final FreeBoardRepository _repository;

  var _state = const PostEditFreeBoardState();

  final _eventController = StreamController<PostEditFreeBoardUiEvent>.broadcast();

  PostEditFreeBoardViewModel(this._repository, FreeBoardInfo? freeBoardInfo) {
    _state = _state.copyWith(freeBoardInfo: freeBoardInfo);
  }

  PostEditFreeBoardState get state => _state;

  Stream<PostEditFreeBoardUiEvent> get eventController => _eventController.stream;

  void onEvent(PostEditFreeBoardEvent event) {
    event.when(
      saveFreeBoard: _saveFreeBoard,
    );
  }

  Future<void> _saveFreeBoard(String? id, String title, String content) async {
    if (title.isEmpty || content.isEmpty) {
      _eventController.add(const PostEditFreeBoardUiEvent.showSnackBar('제목이나 내용이 비어있습니다.'));
      return;
    }

    if (id == null) {
      await _repository.insertFreeBoard(
        FreeBoardInfo(
          title: title,
          content: content,
          // TODO : Auth 연동 시 userName 넘겨줘야 함. AuthController.instance.authentication.currentUser!.displayName
          userName: '',
          timestamp: DateTime.now().millisecondsSinceEpoch,
          isPressedList: [],
          comments: 0,
        ),
      );
    } else {
      await _repository.updateFreeBoard(
        FreeBoardInfo(
          id: id,
          title: title,
          content: content,
          // TODO : Auth 연동 시 userName 넘겨줘야 함. AuthController.instance.authentication.currentUser!.displayName
          userName: '',
          timestamp: DateTime.now().millisecondsSinceEpoch,
          isPressedList: [],
          comments: 0,
        ),
      );
    }

    _eventController.add(const PostEditFreeBoardUiEvent.saveFreeBoard());
  }
}
