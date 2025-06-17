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

  /// 共用：根據秒級 timestamp 範圍查詢
  Future<List<StepDataData>> getByUserAndRange({
    required String userId,
    required DateTime from,
    required DateTime to,
  }) {
    final fromSec = from.millisecondsSinceEpoch ~/ 1000;
    final toSec = to.millisecondsSinceEpoch ~/ 1000;

    return (db.select(db.stepData)
          ..where((tbl) =>
              tbl.userId.equals(userId) &
              tbl.startTimeStamp.isBiggerOrEqualValue(fromSec) &
              tbl.startTimeStamp.isSmallerOrEqualValue(toSec)))
        .get();
  }

  /// 查詢：日
  Future<List<StepDataData>> getDaily(String userId, DateTime date) {
    final start = DateTime(date.year, date.month, date.day);
    final end = start.add(Duration(days: 1)).subtract(Duration(seconds: 1));
    return getByUserAndRange(userId: userId, from: start, to: end);
  }

  /// 查詢：週
  Future<List<StepDataData>> getWeekly(String userId, DateTime date) {
    final start = date.subtract(Duration(days: date.weekday - 1));
    final end = start.add(Duration(days: 7)).subtract(Duration(seconds: 1));
    return getByUserAndRange(userId: userId, from: start, to: end);
  }

  /// 查詢：月
  Future<List<StepDataData>> getMonthly(String userId, DateTime date) {
    final start = DateTime(date.year, date.month, 1);
    final end =
        DateTime(date.year, date.month + 1, 1).subtract(Duration(seconds: 1));
    return getByUserAndRange(userId: userId, from: start, to: end);
  }

  /// 取得今日總步數
  Future<int> getTodayStepTotal(String userId) async {
    final list = await getDaily(userId, DateTime.now());
    final totalSteps = list.fold<int>(0, (sum, item) => sum + (item.step));
    return totalSteps;
  }

  /// 取得今日總距離
  Future<int> getTodayDistanceTotal(String userId) async {
    final list = await getDaily(userId, DateTime.now());
    final totalSteps = list.fold<int>(0, (sum, item) => sum + (item.distance));
    return totalSteps;
  }

  /// 取得今日總卡路里
  Future<int> getTodayCaroliesTotal(String userId) async {
    final list = await getDaily(userId, DateTime.now());
    final totalSteps = list.fold<int>(0, (sum, item) => sum + (item.calories));
    return totalSteps;
  }

  /// 取得尚未同步的資料
  Future<List<StepDataData>> getUnsyncedData(String userId) {
    return (db.select(db.stepData)
          ..where(
              (tbl) => tbl.userId.equals(userId) & tbl.isSynced.equals(false)))
        .get();
  }

  /// 標記為已同步
  Future<void> markAsSynced(List<StepDataData> list) async {
    await db.batch((batch) {
      for (final data in list) {
        batch.update(
          db.stepData,
          const StepDataCompanion(isSynced: Value(true)),
          where: (tbl) =>
              tbl.userId.equals(data.userId) &
              tbl.startTimeStamp.equals(data.startTimeStamp),
        );
      }
    });
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
