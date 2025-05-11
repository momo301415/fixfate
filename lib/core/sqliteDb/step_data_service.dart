import 'package:drift/drift.dart';
import 'package:pulsedevice/core/sqliteDb/app_database.dart';
import 'package:pulsedevice/core/sqliteDb/base_db_service.dart';
import 'package:pulsedevice/core/sqliteDb/tables.dart';
import 'package:yc_product_plugin/yc_product_plugin_data_type.dart';

class StepDataService extends BaseDbService {
  final AppDatabase db;

  StepDataService(this.db) : super(db);

  Future<int> insertStepData(StepDataCompanion data) async {
    return db.into(db.stepData).insert(data, mode: InsertMode.insertOrIgnore);
  }

  Future<List<StepDataData>> getStepDataByUser(String userId) {
    return (db.select(db.stepData)..where((tbl) => tbl.userId.equals(userId)))
        .get();
  }

  Future<void> updateStepData({
    required String userId,
    required int startTimeStamp,
    required StepDataCompanion data,
  }) {
    return (db.update(db.stepData)
          ..where((tbl) =>
              tbl.userId.equals(userId) &
              tbl.startTimeStamp.equals(startTimeStamp)))
        .write(data);
  }

  Future<void> deleteStepData({
    required String userId,
    required int startTimeStamp,
  }) {
    return (db.delete(db.stepData)
          ..where((tbl) =>
              tbl.userId.equals(userId) &
              tbl.startTimeStamp.equals(startTimeStamp)))
        .go();
  }

  /// 同步 SDK 帶來的所有 StepDataInfo，只寫入新的那部分
  Future<void> syncStepData({
    required String userId,
    required List<StepDataInfo> sdkData,
  }) async {
    print('查詢 userId: $userId');
    final all = await db.select(db.stepData).get();
    print('目前 stepData 有 ${all.length} 筆：');
    for (var r in all) {
      print(r.toJson());
    }
    // 1. 拿最後一次同步的 timestamp
    final lastTs = await getLastTimestamp<StepData, StepDataData>(
      table: db.stepData,
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

    print("需要同步的數據比數 StepData:${newItems.length}");

    // 3. 轉成 Companion
    final companions = newItems.map((e) => e.toCompanion(userId)).toList();

    // 4. 批次寫入
    await batchInsert<StepData, StepDataData>(
      table: db.stepData,
      data: companions,
    );
  }
}

extension StepDataMapper on StepDataInfo {
  StepDataCompanion toCompanion(String userId) {
    return StepDataCompanion(
      userId: Value(userId),
      startTimeStamp: Value(startTimeStamp),
      endTimeStamp: Value(endTimeStamp),
      step: Value(step),
      distance: Value(distance),
      calories: Value(calories),
    );
  }
}
