import 'dart:async';
import 'dart:developer';

import 'package:dating_app/domain/repository/auth_repository.dart';
import 'package:dating_app/presentation/auth/auth_event.dart';
import 'package:dating_app/presentation/auth/auth_state.dart';
import 'package:flutter/material.dart';

class AuthViewModel with ChangeNotifier {
  final AuthRepository _repository;

  var _state = const AuthState();

  AuthViewModel(this._repository);

  AuthState get state => _state;

  void onEvent(AuthEvent event) {
    event.when(
      signInWithGoogle: _signInWithGoogle,
      signOut: _signOut,
    );
  }

  Future<void> _signInWithGoogle() async {
    _state = _state.copyWith(
      isLoading: true,
    );
    notifyListeners();

    final result = await _repository.signInWithGoogle();

    result.when(
      success: (userCredential) {
        _state = _state.copyWith(
          userCredential: userCredential,
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

  Future<void> _signOut() async {
    _state = _state.copyWith(
      isLoading: true,
    );
    notifyListeners();

    final result = await _repository.signOut();

    result.when(
      success: (s) {
        _state = _state.copyWith(
          userCredential: null,
          isLoading: false,
        );
      },
      error: (errorMessage) {},
    );

    notifyListeners();
  }
}
