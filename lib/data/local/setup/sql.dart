class Sql {
  final String tableName;
  final String? whereClause;
  final List<dynamic>? whereArgs;
  final Map<String, dynamic>? data;

  Sql({required this.tableName, this.whereClause, this.whereArgs, this.data});
}
