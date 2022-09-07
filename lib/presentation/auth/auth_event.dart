import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_event.freezed.dart';

@freezed
abstract class AuthEvent with _$AuthEvent {
  const factory AuthEvent.signInWithGoogle() = SignInWithGoogle;
  const factory AuthEvent.signOut() = SignOut;
}