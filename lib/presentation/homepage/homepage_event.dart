import 'package:freezed_annotation/freezed_annotation.dart';

part 'homepage_event.freezed.dart';

@freezed
abstract class HomePageEvent with _$HomePageEvent {
  const factory HomePageEvent.selectCurrentPage(int index) = SelectCurrentPage;
}