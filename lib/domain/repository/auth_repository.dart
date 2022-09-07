import 'package:dating_app/util/result.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<Result<UserCredential>> signInWithGoogle();
  Future<Result<void>> signOut();
}
