import 'package:dating_app/domain/model/freeboard_info.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'freeboard_listings_state.freezed.dart';

@freezed
class FreeBoardListingsState with _$FreeBoardListingsState {
  const factory FreeBoardListingsState({
    @Default([]) List<FreeBoardInfo> freeBoards,
    @Default(false) bool isLoading,
    @Default(false) bool isRefreshing,
  }) = _FreeBoardListingsState;
}