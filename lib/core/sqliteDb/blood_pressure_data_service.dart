import 'package:drift/drift.dart';
import 'package:pulsedevice/core/sqliteDb/app_database.dart';
import 'package:pulsedevice/core/sqliteDb/base_db_service.dart';
import 'package:pulsedevice/core/sqliteDb/tables.dart';
import 'package:yc_product_plugin/yc_product_plugin_data_type.dart';

/// 血壓資料服務，使用 (userId, startTimeStamp) 為主鍵
class BloodPressureDataService extends BaseDbService {
  final AppDatabase db;

  BloodPressureDataService(this.db) : super(db);

  /// 新增血壓資料
  Future<int> insert(BloodPressureDataCompanion data) {
    return db
        .into(db.bloodPressureData)
        .insert(data, mode: InsertMode.insertOrIgnore);
  }

  /// 查詢特定使用者血壓資料
  Future<List<BloodPressureDataData>> getByUser(String userId) {
    return (db.select(db.bloodPressureData)
          ..where((tbl) => tbl.userId.equals(userId)))
        .get();
  }

  /// 取得尚未同步的資料
  Future<List<BloodPressureDataData>> getUnsyncedData(String userId) {
    return (db.select(db.bloodPressureData)
          ..where(
              (tbl) => tbl.userId.equals(userId) & tbl.isSynced.equals(false)))
        .get();
  }

  /// 標記為已同步
  Future<void> markAsSynced(List<BloodPressureDataData> list) async {
    await db.batch((batch) {
      for (final data in list) {
        batch.update(
          db.bloodPressureData,
          const BloodPressureDataCompanion(isSynced: Value(true)),
          where: (tbl) =>
              tbl.userId.equals(data.userId) &
              tbl.startTimeStamp.equals(data.startTimeStamp),
        );
      }
    });
  }

  /// 根據複合主鍵更新血壓資料
  Future<void> update(
      String userId, int startTimeStamp, BloodPressureDataCompanion data) {
    return (db.update(db.bloodPressureData)
          ..where((tbl) =>
              tbl.userId.equals(userId) &
              tbl.startTimeStamp.equals(startTimeStamp)))
        .write(data);
  }

  /// 根據複合主鍵刪除血壓資料
  Future<void> delete(String userId, int startTimeStamp) {
    return (db.delete(db.bloodPressureData)
          ..where((tbl) =>
              tbl.userId.equals(userId) &
              tbl.startTimeStamp.equals(startTimeStamp)))
        .go();
  }

  /// 同步 SDK 帶來的所有 BloodPressureDataInfo，只寫入新的那部分
  Future<void> syncBloodPressureData({
    required String userId,
    required List<BloodPressureDataInfo> sdkData,
  }) async {
    // 1. 拿最後一次同步的 timestamp
    final lastTs =
        await getLastTimestamp<BloodPressureData, BloodPressureDataData>(
      table: db.bloodPressureData,
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
    await batchInsert<BloodPressureData, BloodPressureDataData>(
      table: db.bloodPressureData,
      data: companions,
    );
  }
}

/// 將 SDK 血壓資料映射為 Drift Companion
extension BloodPressureDataMapper on BloodPressureDataInfo {
  BloodPressureDataCompanion toCompanion(String userId) {
    return BloodPressureDataCompanion(
      userId: Value(userId),
      startTimeStamp: Value(startTimeStamp),
      systolicBloodPressure: Value(systolicBloodPressure),
      diastolicBloodPressure: Value(diastolicBloodPressure),
      mode: Value(mode),
    );
  }
}
