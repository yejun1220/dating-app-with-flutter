import 'package:freezed_annotation/freezed_annotation.dart';

part 'freeboard_listings_event.freezed.dart';

@freezed
abstract class FreeBoardListingsEvent with _$FreeBoardListingsEvent {
  const factory FreeBoardListingsEvent.loadFreeBoardListings() = LoadFreeBoardListings;
  const factory FreeBoardListingsEvent.refreshFreeBoardListings() = RefreshFreeBoardListings;
}