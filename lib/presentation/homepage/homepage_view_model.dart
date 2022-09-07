import 'package:dating_app/presentation/homepage/homepage_event.dart';
import 'package:dating_app/presentation/homepage/homepage_state.dart';
import 'package:flutter/material.dart';

class HomePageViewModel with ChangeNotifier {
  var _state = const HomePageState();

  HomePageState get state => _state;

  void onEvent(HomePageEvent event) {
    event.when(
      selectCurrentPage: _selectCurrentPage,
    );
  }

  void _selectCurrentPage(int index) {
    _state = _state.copyWith(
      index: index,
    );

    notifyListeners();
  }
}
