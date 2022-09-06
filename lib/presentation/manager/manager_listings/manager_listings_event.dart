import 'package:freezed_annotation/freezed_annotation.dart';

part 'manager_listings_event.freezed.dart';

@freezed
abstract class ManagerListingsEvent with _$ManagerListingsEvent {
  const factory ManagerListingsEvent.loadManagerListings() = LoadManagerListings;
  const factory ManagerListingsEvent.refreshManagerListings() = RefreshManagerListings;
}