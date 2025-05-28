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

  Future<List<CombinedDataData>> getByUserAndRange({
    required String userId,
    required DateTime from,
    required DateTime to,
  }) {
    final fromSec = from.millisecondsSinceEpoch ~/ 1000;
    final toSec = to.millisecondsSinceEpoch ~/ 1000;

    return (db.select(db.combinedData)
          ..where((tbl) =>
              tbl.userId.equals(userId) &
              tbl.startTimeStamp.isBiggerOrEqualValue(fromSec) &
              tbl.startTimeStamp.isSmallerOrEqualValue(toSec)))
        .get();
  }

  /// 查詢：日
  Future<List<CombinedDataData>> getDaily(String userId, DateTime date) {
    final start = DateTime(date.year, date.month, date.day);
    final end = start.add(Duration(days: 1)).subtract(Duration(seconds: 1));
    return getByUserAndRange(userId: userId, from: start, to: end);
  }

  /// 查詢：週
  Future<List<CombinedDataData>> getWeekly(String userId, DateTime date) {
    final start = date.subtract(Duration(days: date.weekday - 1));
    final end = start.add(Duration(days: 7)).subtract(Duration(seconds: 1));
    return getByUserAndRange(userId: userId, from: start, to: end);
  }

  /// 查詢：月
  Future<List<CombinedDataData>> getMonthly(String userId, DateTime date) {
    final start = DateTime(date.year, date.month, 1);
    final end =
        DateTime(date.year, date.month + 1, 1).subtract(Duration(seconds: 1));
    return getByUserAndRange(userId: userId, from: start, to: end);
  }

  /// 取得尚未同步的資料
  Future<List<CombinedDataData>> getUnsyncedData(String userId) {
    return (db.select(db.combinedData)
          ..where(
              (tbl) => tbl.userId.equals(userId) & tbl.isSynced.equals(false)))
        .get();
  }

  /// 標記為已同步
  Future<void> markAsSynced(List<CombinedDataData> list) async {
    await db.batch((batch) {
      for (final data in list) {
        batch.update(
          db.combinedData,
          const CombinedDataCompanion(isSynced: Value(true)),
          where: (tbl) =>
              tbl.userId.equals(data.userId) &
              tbl.startTimeStamp.equals(data.startTimeStamp),
        );
      }
    });
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
      getTimestamp: (row) => row.startTimeStamp,
      timestampField: (t) => t.startTimeStamp,
    );
    print("最後一次同步的 timestamp:$lastTs");
    // 2. 過濾並排序
    final newItems = sdkData
        .where((e) => e.startTimeStamp > (lastTs ?? 0))
        .toList()
      ..sort((a, b) => a.startTimeStamp.compareTo(b.startTimeStamp));
    print("需要同步的數據:$newItems");
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
