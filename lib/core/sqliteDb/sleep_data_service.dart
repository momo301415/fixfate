import 'package:drift/drift.dart';
import 'package:pulsedevice/core/sqliteDb/app_database.dart';
import 'package:pulsedevice/core/sqliteDb/base_db_service.dart';
import 'package:pulsedevice/core/sqliteDb/tables.dart';
import 'package:yc_product_plugin/yc_product_plugin_data_type.dart';

class SleepDataService extends BaseDbService {
  final AppDatabase db;

  SleepDataService(this.db) : super(db);

  Future<void> insertSleepData(SleepDataCompanion data) async {
    await db.into(db.sleepData).insertOnConflictUpdate(data);
  }

  Future<List<SleepDataData>> getSleepDataByUser(String userId) async {
    return (db.select(db.sleepData)..where((tbl) => tbl.userId.equals(userId)))
        .get();
  }

  /// 共用：根據秒級 timestamp 範圍查詢
  Future<List<SleepDataData>> getByUserAndRange({
    required String userId,
    required DateTime from,
    required DateTime to,
  }) {
    final fromSec = from.millisecondsSinceEpoch ~/ 1000;
    final toSec = to.millisecondsSinceEpoch ~/ 1000;

    return (db.select(db.sleepData)
          ..where((tbl) =>
              tbl.userId.equals(userId) &
              tbl.endTimeStamp.isBiggerOrEqualValue(fromSec) & // 有部分結束在 today
              tbl.startTimeStamp.isSmallerOrEqualValue(toSec))) // 有部分開始在 today
        .get();
  }

  Future<List<SleepDataData>> getDailyByEndTime(String userId, DateTime date) {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay
        .add(const Duration(days: 1))
        .subtract(const Duration(seconds: 1));

    final fromSec = startOfDay.millisecondsSinceEpoch ~/ 1000;
    final toSec = endOfDay.millisecondsSinceEpoch ~/ 1000;

    return (db.select(db.sleepData)
          ..where((tbl) =>
              tbl.userId.equals(userId) &
              tbl.endTimeStamp.isBiggerOrEqualValue(fromSec) &
              tbl.endTimeStamp.isSmallerOrEqualValue(toSec)))
        .get();
  }

  /// 查詢：日
  Future<List<SleepDataData>> getDaily(String userId, DateTime date) {
    final start = DateTime(date.year, date.month, date.day);
    final end = start.add(Duration(days: 1)).subtract(Duration(seconds: 1));
    return getDailyByEndTime(userId, end);
  }

  /// 查詢：週
  Future<List<SleepDataData>> getWeekly(String userId, DateTime date) {
    final start = date.subtract(Duration(days: date.weekday - 1));
    final end = start.add(Duration(days: 7)).subtract(Duration(seconds: 1));
    return getByUserAndRange(userId: userId, from: start, to: end);
  }

  /// 查詢：月
  Future<List<SleepDataData>> getMonthly(String userId, DateTime date) {
    final start = DateTime(date.year, date.month, 1);
    final end =
        DateTime(date.year, date.month + 1, 1).subtract(Duration(seconds: 1));
    return getByUserAndRange(userId: userId, from: start, to: end);
  }

  /// 取得今日睡眠總秒數
  Future<int> getTodaySleepTotalSeconds(String userId) async {
    final list = await getDaily(userId, DateTime.now());

    final totalSeconds = list.fold<int>(
      0,
      (sum, item) => sum + ((item.endTimeStamp - item.startTimeStamp)),
    );

    return totalSeconds;
  }

  /// 取得尚未同步的資料
  Future<List<SleepDataData>> getUnsyncedData(String userId) {
    return (db.select(db.sleepData)
          ..where(
              (tbl) => tbl.userId.equals(userId) & tbl.isSynced.equals(false)))
        .get();
  }

  /// 標記為已同步
  Future<void> markAsSynced(List<SleepDataData> list) async {
    await db.batch((batch) {
      for (final data in list) {
        batch.update(
          db.sleepData,
          const SleepDataCompanion(isSynced: Value(true)),
          where: (tbl) =>
              tbl.userId.equals(data.userId) &
              tbl.startTimeStamp.equals(data.startTimeStamp),
        );
      }
    });
  }

  Future<void> insertSleepDetails(String userId, int parentStartTimeStamp,
      List<SleepDetailDataCompanion> details) async {
    for (final detail in details) {
      final complete = detail.copyWith(
        userId: Value(userId),
        startTimeStamp: Value(parentStartTimeStamp),
      );
      await db.into(db.sleepDetailData).insertOnConflictUpdate(complete);
    }
  }

  Future<List<SleepDataWithDetails>> getSleepDataWithDetails(
      String userId) async {
    final records = await getSleepDataByUser(userId);

    final result = <SleepDataWithDetails>[];
    for (final record in records) {
      final detailList = await (db.select(db.sleepDetailData)
            ..where((d) =>
                d.userId.equals(record.userId) &
                d.startTimeStamp.equals(record.startTimeStamp)))
          .get();
      result.add(SleepDataWithDetails(data: record, details: detailList));
    }
    return result;
  }

  /// 共用：根據秒級 timestamp 範圍查詢
  Future<List<SleepDetailDataData>> getByUserAndRangeDetails({
    required String userId,
    required DateTime from,
    required DateTime to,
  }) {
    final fromSec = from.millisecondsSinceEpoch ~/ 1000;
    final toSec = to.millisecondsSinceEpoch ~/ 1000;

    return (db.select(db.sleepDetailData)
          ..where((tbl) =>
              tbl.userId.equals(userId) &
              tbl.startTimeStamp.isBiggerOrEqualValue(fromSec) &
              tbl.startTimeStamp.isSmallerOrEqualValue(toSec)))
        .get();
  }

  /// 查詢：日
  Future<List<SleepDetailDataData>> getDailyDetails(
      String userId, DateTime date) {
    final start = DateTime(date.year, date.month, date.day);
    final end = start.add(Duration(days: 1)).subtract(Duration(seconds: 1));
    return getByUserAndRangeDetails(userId: userId, from: start, to: end);
  }

  /// 查詢：週
  Future<List<SleepDetailDataData>> getWeeklyDetails(
      String userId, DateTime date) {
    final start = date.subtract(Duration(days: date.weekday - 1));
    final end = start.add(Duration(days: 7)).subtract(Duration(seconds: 1));
    return getByUserAndRangeDetails(userId: userId, from: start, to: end);
  }

  /// 查詢：月
  Future<List<SleepDetailDataData>> getMonthlyDetials(
      String userId, DateTime date) {
    final start = DateTime(date.year, date.month, 1);
    final end =
        DateTime(date.year, date.month + 1, 1).subtract(Duration(seconds: 1));
    return getByUserAndRangeDetails(userId: userId, from: start, to: end);
  }

  /// 取得尚未同步的資料
  Future<List<SleepDetailDataData>> getUnsyncedDetailsData(String userId) {
    return (db.select(db.sleepDetailData)
          ..where(
              (tbl) => tbl.userId.equals(userId) & tbl.isSynced.equals(false)))
        .get();
  }

  /// 標記為已同步
  Future<void> markDetailsAsSynced(List<SleepDetailDataData> list) async {
    await db.batch((batch) {
      for (final data in list) {
        batch.update(
          db.sleepDetailData,
          const SleepDetailDataCompanion(isSynced: Value(true)),
          where: (tbl) =>
              tbl.userId.equals(data.userId) &
              tbl.startTimeStamp.equals(data.startTimeStamp),
        );
      }
    });
  }

  Future<void> deleteSleepData(String userId, int startTimeStamp) async {
    await db.transaction(() async {
      await (db.delete(db.sleepDetailData)
            ..where((tbl) =>
                tbl.userId.equals(userId) &
                tbl.startTimeStamp.equals(startTimeStamp)))
          .go();
      await (db.delete(db.sleepData)
            ..where((tbl) =>
                tbl.userId.equals(userId) &
                tbl.startTimeStamp.equals(startTimeStamp)))
          .go();
    });
  }

  /// 同步 SDK 帶來的所有 SleepDataInfo，只寫入新的那部分
  /// 同步 SleepData summary + detail
  Future<void> syncSleepData({
    required String userId,
    required List<SleepDataInfo> sdkData,
  }) async {
    // 1️⃣ 拿到本機最後一筆 SleepData 的 startTimeStamp
    final lastTs = await getLastTimestamp<SleepData, SleepDataData>(
      table: db.sleepData,
      userIdField: (t) => t.userId,
      userId: userId,
      getTimestamp: (row) => row.startTimeStamp,
      timestampField: (t) => t.startTimeStamp,
    );

    // 2️⃣ 過濾出新的 Session，並升冪排序
    final newSessions = sdkData
        .where((s) => s.startTimeStamp > (lastTs ?? 0))
        .toList()
      ..sort((a, b) => a.startTimeStamp.compareTo(b.startTimeStamp));

    if (newSessions.isEmpty) return;

    // 3️⃣ 將每個 SleepDataInfo 轉成 Companion
    final sessionCompanions =
        newSessions.map((s) => s.toCompanion(userId)).toList();

    // 4️⃣ 批次寫入 SleepData（有衝突則 update）
    await batchInsert<SleepData, SleepDataData>(
      table: db.sleepData,
      data: sessionCompanions,
    );

    // 5️⃣ 轉出所有 detail 的 Companion
    final detailCompanions = <SleepDetailDataCompanion>[];
    for (final session in newSessions) {
      detailCompanions.addAll(
        session.list.map(
          (d) => d.toCompanion(userId, session.startTimeStamp),
        ),
      );
    }

    // 6️⃣ 批次寫入 SleepDetailData
    await batchInsert<SleepDetailData, SleepDetailDataData>(
      table: db.sleepDetailData,
      data: detailCompanions,
    );
  }
}

class SleepDataWithDetails {
  final SleepDataData data;
  final List<SleepDetailDataData> details;

  SleepDataWithDetails({required this.data, required this.details});
}

extension SleepDataMapper on SleepDataInfo {
  SleepDataCompanion toCompanion(String userId) {
    return SleepDataCompanion(
      userId: Value(userId),
      startTimeStamp: Value(startTimeStamp),
      endTimeStamp: Value(endTimeStamp),
      deepSleepSeconds: Value(deepSleepSeconds),
      lightSleepSeconds: Value(lightSleepSeconds),
      remSleepSeconds: Value(remSleepSeconds),
      isNewSleepProtocol: Value(isNewSleepProtocol),
    );
  }
}

extension SleepDetailDataMapper on SleepDetailDataInfo {
  SleepDetailDataCompanion toCompanion(String userId, int sleepStart) {
    return SleepDetailDataCompanion(
      userId: Value(userId),
      sleepStartTimeStamp: Value(sleepStart),
      startTimeStamp: Value(startTimeStamp),
      duration: Value(duration),
      sleepType: Value(sleepType),
    );
  }
}
