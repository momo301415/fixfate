import 'package:drift/drift.dart';
import 'package:pulsedevice/core/sqliteDb/app_database.dart';
import 'package:pulsedevice/core/sqliteDb/base_db_service.dart';
import 'package:pulsedevice/core/sqliteDb/tables.dart';
import 'package:yc_product_plugin/yc_product_plugin_data_type.dart';

/// 心率資料服務，使用主鍵為 (userId, startTimeStamp)
class HeartRateDataService extends BaseDbService {
  final AppDatabase db;

  HeartRateDataService(this.db) : super(db);

  /// 插入心率資料
  Future<int> insert(HeartRateDataCompanion data) {
    return db
        .into(db.heartRateData)
        .insert(data, mode: InsertMode.insertOrIgnore);
  }

  /// 根據 userId 查詢全部資料
  Future<List<HeartRateDataData>> getByUser(String userId) {
    return (db.select(db.heartRateData)
          ..where((tbl) => tbl.userId.equals(userId)))
        .get();
  }

  /// 共用：根據秒級 timestamp 範圍查詢
  Future<List<HeartRateDataData>> getByUserAndRange({
    required String userId,
    required DateTime from,
    required DateTime to,
  }) {
    final fromSec = from.millisecondsSinceEpoch ~/ 1000;
    final toSec = to.millisecondsSinceEpoch ~/ 1000;

    return (db.select(db.heartRateData)
          ..where((tbl) =>
              tbl.userId.equals(userId) &
              tbl.startTimeStamp.isBiggerOrEqualValue(fromSec) &
              tbl.startTimeStamp.isSmallerOrEqualValue(toSec)))
        .get();
  }

  /// 查詢：日
  Future<List<HeartRateDataData>> getDaily(String userId, DateTime date) {
    final start = DateTime(date.year, date.month, date.day);
    final end = start.add(Duration(days: 1)).subtract(Duration(seconds: 1));
    return getByUserAndRange(userId: userId, from: start, to: end);
  }

  /// 查詢：週
  Future<List<HeartRateDataData>> getWeekly(String userId, DateTime date) {
    final start = date.subtract(Duration(days: date.weekday - 1));
    final end = start.add(Duration(days: 7)).subtract(Duration(seconds: 1));
    return getByUserAndRange(userId: userId, from: start, to: end);
  }

  /// 查詢：月
  Future<List<HeartRateDataData>> getMonthly(String userId, DateTime date) {
    final start = DateTime(date.year, date.month, 1);
    final end =
        DateTime(date.year, date.month + 1, 1).subtract(Duration(seconds: 1));
    return getByUserAndRange(userId: userId, from: start, to: end);
  }

  /// 取得尚未同步的資料
  Future<List<HeartRateDataData>> getUnsyncedData(String userId) {
    return (db.select(db.heartRateData)
          ..where(
              (tbl) => tbl.userId.equals(userId) & tbl.isSynced.equals(false)))
        .get();
  }

  /// 標記為已同步
  Future<void> markAsSynced(List<HeartRateDataData> list) async {
    await db.batch((batch) {
      for (final data in list) {
        batch.update(
          db.heartRateData,
          const HeartRateDataCompanion(isSynced: Value(true)),
          where: (tbl) =>
              tbl.userId.equals(data.userId) &
              tbl.startTimeStamp.equals(data.startTimeStamp),
        );
      }
    });
  }

  /// 根據複合主鍵更新資料
  Future<void> update(
      String userId, int startTimeStamp, HeartRateDataCompanion data) {
    return (db.update(db.heartRateData)
          ..where((tbl) =>
              tbl.userId.equals(userId) &
              tbl.startTimeStamp.equals(startTimeStamp)))
        .write(data);
  }

  /// 根據複合主鍵刪除資料
  Future<void> delete(String userId, int startTimeStamp) {
    return (db.delete(db.heartRateData)
          ..where((tbl) =>
              tbl.userId.equals(userId) &
              tbl.startTimeStamp.equals(startTimeStamp)))
        .go();
  }

  /// 同步 SDK 帶來的所有 HeartRateDataInfo，只寫入新的那部分
  Future<void> syncHeartRateData({
    required String userId,
    required List<HeartRateDataInfo> sdkData,
  }) async {
    // 1. 拿最後一次同步的 timestamp
    final lastTs = await getLastTimestamp<HeartRateData, HeartRateDataData>(
      table: db.heartRateData,
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
    await batchInsert<HeartRateData, HeartRateDataData>(
      table: db.heartRateData,
      data: companions,
    );
  }
}

/// 將 SDK HeartRateDataInfo 映射為 DB companion
extension HeartRateDataMapper on HeartRateDataInfo {
  HeartRateDataCompanion toCompanion(String userId) {
    return HeartRateDataCompanion(
      userId: Value(userId),
      startTimeStamp: Value(startTimeStamp),
      heartRate: Value(heartRate),
    );
  }
}
