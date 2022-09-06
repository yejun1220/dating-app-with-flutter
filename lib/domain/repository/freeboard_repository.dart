import 'package:dating_app/domain/model/freeboard_info.dart';
import 'package:dating_app/util/result.dart';

abstract class FreeBoardRepository {

  Future<Result<FreeBoardInfo>> getFreeBoard(String id);

  Future<Result<List<FreeBoardInfo>>> getFreeBoardListings();

  Future<Result<void>> insertFreeBoard(FreeBoardInfo freeBoard);

  Future<Result<void>> updateFreeBoard(FreeBoardInfo freeBoard);

  Future<Result<void>> deleteFreeBoard(String id);


}
