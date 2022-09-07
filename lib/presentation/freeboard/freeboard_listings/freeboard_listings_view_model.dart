import 'dart:developer';

import 'package:dating_app/domain/repository/freeboard_repository.dart';
import 'package:dating_app/presentation/freeboard/freeboard_listings/freeboard_listings_event.dart';
import 'package:dating_app/presentation/freeboard/freeboard_listings/freeboard_listings_state.dart';
import 'package:flutter/material.dart';

class FreeBoardListingsViewModel with ChangeNotifier {
  final FreeBoardRepository _repository;

  var _state = const FreeBoardListingsState();

  FreeBoardListingsViewModel(this._repository) {
    _loadFreeBoardListings();
  }

  FreeBoardListingsState get state => _state;

  void onEvent(FreeBoardListingsEvent event) {
    event.when(
      loadFreeBoardListings: _loadFreeBoardListings,
      refreshFreeBoardListings: _refreshFreeBoardListings,
    );
  }

  Future<void> _loadFreeBoardListings() async {
    _state = _state.copyWith(
      isLoading: true,
    );
    notifyListeners();

    final result = await _repository.getFreeBoardListings();

    result.when(
      success: (freeBoards) {
        _state = _state.copyWith(
          freeBoards: freeBoards,
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

  Future<void> _refreshFreeBoardListings() async {
    _state = _state.copyWith(
      isRefreshing: true,
    );

    notifyListeners();

    final result = await _repository.getFreeBoardListings();

    result.when(
      success: (freeBoards) {
        _state = _state.copyWith(
          freeBoards: freeBoards,
          isRefreshing: false,
        );
      },
      error: (errorMessage) {
        _state = _state.copyWith(
          isRefreshing: false,
        );
        log(errorMessage);
      },
    );

    notifyListeners();
  }
}
