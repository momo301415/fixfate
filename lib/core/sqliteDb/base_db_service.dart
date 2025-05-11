import 'package:drift/drift.dart';

abstract class BaseDbService {
  final GeneratedDatabase db;
  BaseDbService(this.db);

  /// 取出某張表、某個 userId 的最後一筆 timestamp
  Future<int?> getLastTimestamp<TABLE extends Table, DATA>({
    required TableInfo<TABLE, DATA> table,
    required Column<String> Function(TABLE tbl) userIdField,
    required String userId,
    required Column<int> Function(TABLE tbl) timestampField,
    required int Function(DATA row) getTimestamp, // ✅ 用這個來安全取值
  }) async {
    final query = db.select(table)
      ..where((tbl) => userIdField(tbl).equals(userId))
      ..orderBy([(tbl) => OrderingTerm.desc(timestampField(tbl))])
      ..limit(1);

    final row = await query.getSingleOrNull();
    return row != null ? getTimestamp(row) : null;
  }

  /// 泛用批次插入（Insertable<DATA> 就是你的 Companion）
  Future<void> batchInsert<TABLE extends Table, DATA>({
    required TableInfo<TABLE, DATA> table,
    required List<Insertable<DATA>> data,
  }) async {
    if (data.isEmpty) return;
    await db.batch((batch) {
      batch.insertAllOnConflictUpdate<TABLE, DATA>(table, data);
    });
  }
}
