import 'dart:async';

import '../../../support/exceptions/local_database_exception.dart';
import '../../../support/utils/either.dart';
import 'sql.dart';

typedef DatabaseResponse<T> = FutureOr<Either<LocalDatabaseException, T>>;

abstract class DatabaseAccessor {
  FutureOr<void> openDatabase();
  FutureOr<void> execute(String sql);
  DatabaseResponse<List<Map<String, dynamic>>> customQuery(String query);
  DatabaseResponse<List<Map<String, dynamic>>> getData({required Sql sql});
  DatabaseResponse<int> insertData({required Sql sql});
  DatabaseResponse<int> updateData({required Sql sql});
  DatabaseResponse<int> deleteData({required Sql sql});
  FutureOr<void> close();
}
