import 'package:dating_app/data/data_source/firebase_api.dart';
import 'package:dating_app/domain/model/manager.dart';
import 'package:dating_app/domain/repository/manager_repository.dart';
import 'package:dating_app/util/result.dart';

class ManagerRepositoryImpl implements ManagerRepository {
  final FirebaseApi _firebaseApi;

  ManagerRepositoryImpl(this._firebaseApi);
  @override
  Future<Result<List<Manager>>> getManagerListings() async {
    try {
      final result = await _firebaseApi.getManagerListings();
      return Result.success(result);
    } catch (e) {
      return Result.error('매니저 정보 로드 실패: $e');
    }

  }
}