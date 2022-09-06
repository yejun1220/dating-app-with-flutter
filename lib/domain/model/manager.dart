import 'package:freezed_annotation/freezed_annotation.dart';

part 'manager.freezed.dart';
part 'manager.g.dart';

@freezed
class Manager with _$Manager {
  const factory Manager({
    required String id,
    required String userName,
    required String email,
    required String role,
    required String photoURL,
    required String area,
    required int ageGroup,
    required String description,
  }) = _Manager;

  factory Manager.fromJson(Map<String, dynamic> json) => _$ManagerFromJson(json);
}
