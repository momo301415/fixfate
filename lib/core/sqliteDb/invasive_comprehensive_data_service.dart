import 'package:drift/drift.dart';
import 'package:pulsedevice/core/sqliteDb/app_database.dart';
import 'package:pulsedevice/core/sqliteDb/base_db_service.dart';
import 'package:pulsedevice/core/sqliteDb/tables.dart';
import 'package:yc_product_plugin/yc_product_plugin_data_type.dart';

class InvasiveComprehensiveDataService extends BaseDbService {
  final AppDatabase db;

  InvasiveComprehensiveDataService(this.db) : super(db);

  Future<int> insert(InvasiveComprehensiveDataCompanion data) {
    return db
        .into(db.invasiveComprehensiveData)
        .insert(data, mode: InsertMode.insertOrIgnore);
  }

  Future<List<InvasiveComprehensiveDataData>> getByUser(String userId) {
    return (db.select(db.invasiveComprehensiveData)
          ..where((tbl) => tbl.userId.equals(userId)))
        .get();
  }

  Future<void> update(String userId, int startTimeStamp,
      InvasiveComprehensiveDataCompanion data) {
    return (db.update(db.invasiveComprehensiveData)
          ..where((tbl) =>
              tbl.userId.equals(userId) &
              tbl.startTimeStamp.equals(startTimeStamp)))
        .write(data);
  }

  Future<void> delete(String userId, int startTimeStamp) {
    return (db.delete(db.invasiveComprehensiveData)
          ..where((tbl) =>
              tbl.userId.equals(userId) &
              tbl.startTimeStamp.equals(startTimeStamp)))
        .go();
  }

  /// 同步 SDK 帶來的所有 InvasiveComprehensiveDataInfo，只寫入新的那部分
  Future<void> syncInvasiveComprehensiveData({
    required String userId,
    required List<InvasiveComprehensiveDataInfo> sdkData,
  }) async {
    // 1. 拿最後一次同步的 timestamp
    final lastTs = await getLastTimestamp<InvasiveComprehensiveData,
        InvasiveComprehensiveDataData>(
      table: db.invasiveComprehensiveData,
      userIdField: (t) => t.userId,
      userId: userId,
      getTimestamp: (row) => row.startTimeStamp,
      timestampField: (t) => t.startTimeStamp,
    );
    // 2. 過濾並排序
    final newItems = sdkData
        .where((e) => e.startTimeStamp > (lastTs ?? 0))
        .toList()
      ..sort((a, b) => a.startTimeStamp.compareTo(b.startTimeStamp));

    if (newItems.isEmpty) return;

    // 3. 轉成 Companion
    final companions = newItems.map((e) => e.toCompanion(userId)).toList();

    // 4. 批次寫入
    await batchInsert<InvasiveComprehensiveData, InvasiveComprehensiveDataData>(
      table: db.invasiveComprehensiveData,
      data: companions,
    );
  }
}

extension InvasiveComprehensiveDataMapper on InvasiveComprehensiveDataInfo {
  InvasiveComprehensiveDataCompanion toCompanion(String userId) {
    return InvasiveComprehensiveDataCompanion(
      userId: Value(userId),
      startTimeStamp: Value(startTimeStamp),
      bloodGlucoseMode: Value(bloodGlucoseMode),
      bloodGlucose: Value(bloodGlucose),
      uricAcidMode: Value(uricAcidMode),
      uricAcid: Value(uricAcid),
      bloodKetoneMode: Value(bloodKetoneMode),
      bloodKetone: Value(bloodKetone),
      bloodFatMode: Value(bloodFatMode),
      totalCholesterol: Value(totalCholesterol),
      hdlCholesterol: Value(hdlCholesterol),
      ldlCholesterol: Value(ldlCholesterol),
      triglycerides: Value(triglycerides),
    );
  }
}
