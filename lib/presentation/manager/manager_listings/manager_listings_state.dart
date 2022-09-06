import 'package:dating_app/domain/model/manager.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'manager_listings_state.freezed.dart';

part 'manager_listings_state.g.dart';

@freezed
class ManagerListingsState with _$ManagerListingsState {
  const factory ManagerListingsState({
    @Default([]) List<Manager> managers,
    @Default(false) bool isLoading,
    @Default(false) bool isRefreshing,
    @Default('') String searchQuery,
  }) = _ManagerListingsState;

  factory ManagerListingsState.fromJson(Map<String, Object?> json) => _$ManagerListingsStateFromJson(json);
}