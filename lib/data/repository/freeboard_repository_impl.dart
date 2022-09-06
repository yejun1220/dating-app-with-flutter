import 'package:dating_app/data/data_source/firebase_api.dart';
import 'package:dating_app/domain/model/freeboard_info.dart';
import 'package:dating_app/domain/repository/freeboard_repository.dart';
import 'package:dating_app/util/result.dart';

class FreeBoardRepositoryImpl implements FreeBoardRepository {
  final FirebaseApi _firebaseApi;

  FreeBoardRepositoryImpl(this._firebaseApi);

  @override
  Future<Result<FreeBoardInfo>> getFreeBoard(String id) async {
    try {
      final result = await _firebaseApi.getFreeBoard(id);
      return Result.success(result);
    } catch (e) {
      return Result.error('게시판 상세 정보 로드 실패: $e');
    }
  }

  @override
  Future<Result<List<FreeBoardInfo>>> getFreeBoardListings() async {
    try {
      final result = await _firebaseApi.getFreeBoardListings();
      return Result.success(result);
    } catch (e) {
      return Result.error('게시판 리스트 정보 로드 실패: $e');
    }
  }

  @override
  Future<Result<void>> insertFreeBoard(FreeBoardInfo freeBoard) async {
    try {
      final result = await _firebaseApi.insertFreeBoard(freeBoard);
      return Result.success(result);
    } catch (e) {
      return Result.error('게시판 작성 실패: $e');
    }
  }

  @override
  Future<Result<void>> updateFreeBoard(FreeBoardInfo freeBoard) async {
    try {
      final result = await _firebaseApi.updateFreeBoard(freeBoard);
      return Result.success(result);
    } catch (e) {
      return Result.error('게시판 수정 실패: $e');
    }
  }

  @override
  Future<Result<void>> deleteFreeBoard(String id) async {
    try {
      final result = await _firebaseApi.deleteFreeBoard(id);
      return Result.success(result);
    } catch (e) {
      return Result.error('게시판 삭제 실패: $e');
    }
  }


}