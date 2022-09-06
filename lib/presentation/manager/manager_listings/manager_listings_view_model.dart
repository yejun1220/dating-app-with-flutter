import 'dart:developer';

import 'package:dating_app/domain/repository/manager_repository.dart';
import 'package:dating_app/presentation/manager/manager_listings/manager_listings_event.dart';
import 'package:dating_app/presentation/manager/manager_listings/manager_listings_state.dart';
import 'package:flutter/material.dart';

class ManagerListingsViewModel with ChangeNotifier {
  final ManagerRepository _repository;

  var _state = const ManagerListingsState();

  ManagerListingsViewModel(this._repository) {
    _getManagers();
  }

  ManagerListingsState get state => _state;

  void onEvent(ManagerListingsEvent event) {
    event.when(
      loadManagerListings: _getManagers,
      refreshManagerListings: _refreshManagerListings,
    );
  }

  Future<void> _getManagers() async {
    _state = _state.copyWith(
      isLoading: true,
    );
    notifyListeners();

    final result = await _repository.getManagerListings();

    result.when(
      success: (managers) {
        _state = _state.copyWith(
          managers: managers,
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

  void _refreshManagerListings() async {
    _state = _state.copyWith(
      isRefreshing: true,
    );
    notifyListeners();

    final result = await _repository.getManagerListings();

    result.when(
      success: (managers) {
        _state = _state.copyWith(
          managers: managers,
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
