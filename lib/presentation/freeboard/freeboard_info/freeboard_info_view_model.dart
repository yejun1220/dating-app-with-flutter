import 'dart:async';
import 'dart:developer';

import 'package:dating_app/domain/repository/freeboard_repository.dart';
import 'package:dating_app/presentation/freeboard/freeboard_info/freeboard_info_event.dart';
import 'package:dating_app/presentation/freeboard/freeboard_info/freeboard_info_state.dart';
import 'package:dating_app/presentation/freeboard/freeboard_info/freeboard_info_ui_event.dart';
import 'package:flutter/material.dart';

class FreeBoardInfoViewModel with ChangeNotifier {
  final FreeBoardRepository _repository;

  var _state = const FreeBoardInfoState();

  final _eventController = StreamController<FreeBoardInfoUiEvent>.broadcast();

  FreeBoardInfoViewModel(this._repository, String id) {
    _loadFreeBoardInfo(id);
  }

  FreeBoardInfoState get state => _state;

  Stream<FreeBoardInfoUiEvent> get eventController => _eventController.stream;

  void onEvent(FreeBoardInfoEvent event) {
    event.when(
      loadFreeBoardInfo: _loadFreeBoardInfo,
      deleteFreeBoardInfo: _deleteFreeBoardInfo,
    );
  }

  Future<void> _loadFreeBoardInfo(String id) async {
    _state = _state.copyWith(isLoading: true);
    final result = await _repository.getFreeBoard(id);

    result.when(
      success: (freeBoardInfo) {
        _state = _state.copyWith(
          freeBoardInfo: freeBoardInfo,
          isLoading: false,
        );
      },
      error: (errorMessage) {
        _state = _state.copyWith(
          isLoading: false,
        );
        log(errorMessage);
      },
    );

    notifyListeners();
  }

  Future<void> _deleteFreeBoardInfo(String id) async {
    _state = _state.copyWith(isLoading: true);
    final result = await _repository.deleteFreeBoard(id);

    result.when(
      success: (freeBoardInfo) {
        _state = _state.copyWith(
          isLoading: false,
        );
      },
      error: (errorMessage) {
        _state = _state.copyWith(
          isLoading: false,
        );
        log(errorMessage);
      },
    );

    _eventController.add(const FreeBoardInfoUiEvent.deleteFreeBoard());
  }
}
