import 'package:dating_app/domain/repository/auth_repository.dart';
import 'package:dating_app/util/result.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../data_source/firebase_api.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseApi _firebaseApi;

  AuthRepositoryImpl(this._firebaseApi);

  @override
  Future<Result<UserCredential>> signInWithGoogle() async {
    try {
      final result = await _firebaseApi.signInWithGoogle();
      return Result.success(result);
    } catch (e) {
      return Result.error('구글 로그인 실패: $e');
    }
  }

  @override
  Future<Result<void>> signOut() async {
    try {
      final result = await _firebaseApi.signOut();
      return Result.success(result);
    } catch (e) {
      return Result.error('로그아웃 실패: $e');
    }
  }


}