import 'package:dating_app/presentation/freeboard/freeboard_listings/freeboard_listings_screen.dart';
import 'package:dating_app/presentation/manager/manager_listings/manager_listings_screen.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'homepage_state.freezed.dart';

@freezed
class HomePageState with _$HomePageState {
  const factory HomePageState({
    @Default(0) int index,
    @Default([ManagerListingsScreen(), FreeBoardListingsScreen()]) List<StatelessWidget> pageOptions,
  }) = _HomePageState;

}
