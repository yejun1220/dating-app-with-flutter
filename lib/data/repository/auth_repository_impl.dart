import 'package:dating_app/data/data_source/firebase_api.dart';
import 'package:dating_app/domain/repository/auth_repository.dart';
import 'package:dating_app/util/result.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  @override
  Result<User?> getUser() {
   try {
     final result = _firebaseApi.getUser();
     return Result.success(result);
   }
   catch (e) {
     return Result.error('유저 가져오기 실패: $e');
   }
  }

  @override
  Result<Stream<User?>> authStateChanges() {
    try {
      final result = _firebaseApi.authStateChanges();
      return Result.success(result);
    }
    catch (e) {
      return Result.error('인증 변환 감지 실패: $e');
    }
  }

}