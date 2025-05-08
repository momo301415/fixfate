import 'package:drift/drift.dart';
import 'package:pulsedevice/core/sqliteDb/app_database.dart';
import 'package:pulsedevice/core/sqliteDb/base_db_service.dart';
import 'package:pulsedevice/core/sqliteDb/tables.dart';
import 'package:yc_product_plugin/yc_product_plugin.dart';

class CombinedDataService extends BaseDbService {
  final AppDatabase db;

  CombinedDataService(this.db) : super(db);

  Future<int> insert(CombinedDataCompanion data) {
    return db
        .into(db.combinedData)
        .insert(data, mode: InsertMode.insertOrIgnore);
  }

  Future<List<CombinedDataData>> getByUser(String userId) {
    return (db.select(db.combinedData)
          ..where((tbl) => tbl.userId.equals(userId)))
        .get();
  }

  Future<void> update(
      String userId, int startTimeStamp, CombinedDataCompanion data) {
    return (db.update(db.combinedData)
          ..where((tbl) =>
              tbl.userId.equals(userId) &
              tbl.startTimeStamp.equals(startTimeStamp)))
        .write(data);
  }

  Future<void> delete(String userId, int startTimeStamp) {
    return (db.delete(db.combinedData)
          ..where((tbl) =>
              tbl.userId.equals(userId) &
              tbl.startTimeStamp.equals(startTimeStamp)))
        .go();
  }

  /// 同步 SDK 帶來的所有 CombinedDataDataInfo，只寫入新的那部分
  Future<void> syncCombinedData({
    required String userId,
    required List<CombinedDataDataInfo> sdkData,
  }) async {
    // 1. 拿最後一次同步的 timestamp
    final lastTs = await getLastTimestamp<CombinedData, CombinedDataData>(
      table: db.combinedData,
      userIdField: (t) => t.userId,
      userId: userId,
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
    await batchInsert<CombinedData, CombinedDataData>(
      table: db.combinedData,
      data: companions,
    );
  }
}

extension CombinedDataMapper on CombinedDataDataInfo {
  CombinedDataCompanion toCompanion(String userId) {
    return CombinedDataCompanion(
      userId: Value(userId),
      startTimeStamp: Value(startTimeStamp),
      step: Value(step),
      heartRate: Value(heartRate),
      systolicBloodPressure: Value(systolicBloodPressure),
      diastolicBloodPressure: Value(diastolicBloodPressure),
      bloodOxygen: Value(bloodOxygen),
      respirationRate: Value(respirationRate),
      hrv: Value(hrv),
      cvrr: Value(cvrr),
      bloodGlucose: Value(bloodGlucose),
      fat: Value(fat),
      temperature: Value(temperature),
    );
  }
}
