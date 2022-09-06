import 'package:dating_app/domain/model/manager.dart';
import 'package:dating_app/util/result.dart';

abstract class ManagerRepository {
  Future<Result<List<Manager>>> getManagerListings();
}
