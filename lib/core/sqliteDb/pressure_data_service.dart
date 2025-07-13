import 'package:drift/drift.dart';
import 'package:pulsedevice/core/sqliteDb/app_database.dart';
import 'package:pulsedevice/core/sqliteDb/base_db_service.dart';
import 'package:pulsedevice/core/sqliteDb/tables.dart';

/// 壓力數據服務，使用主鍵為 (userId, startTimeStamp)
class PressureDataService extends BaseDbService {
  final AppDatabase db;

  PressureDataService(this.db) : super(db);

  /// 插入壓力資料
  Future<int> insert(PressureDataCompanion data) {
    return db
        .into(db.pressureData)
        .insert(data, mode: InsertMode.insertOrIgnore);
  }

  /// 根據 userId 查詢全部資料
  Future<List<PressureDataData>> getByUser(String userId) {
    return (db.select(db.pressureData)
          ..where((tbl) => tbl.userId.equals(userId)))
        .get();
  }

  /// 共用：根據秒級 timestamp 範圍查詢
  Future<List<PressureDataData>> getByUserAndRange({
    required String userId,
    required DateTime from,
    required DateTime to,
  }) {
    final fromSec = from.millisecondsSinceEpoch ~/ 1000;
    final toSec = to.millisecondsSinceEpoch ~/ 1000;

    return (db.select(db.pressureData)
          ..where((tbl) =>
              tbl.userId.equals(userId) &
              tbl.startTimeStamp.isBiggerOrEqualValue(fromSec) &
              tbl.startTimeStamp.isSmallerOrEqualValue(toSec)))
        .get();
  }

  /// 查詢：日
  Future<List<PressureDataData>> getDaily(String userId, DateTime date) {
    final start = DateTime(date.year, date.month, date.day);
    final end = start.add(Duration(days: 1)).subtract(Duration(seconds: 1));
    return getByUserAndRange(userId: userId, from: start, to: end);
  }

  /// 查詢：週
  Future<List<PressureDataData>> getWeekly(String userId, DateTime date) {
    final start = date.subtract(Duration(days: date.weekday - 1));
    final end = start.add(Duration(days: 7)).subtract(Duration(seconds: 1));
    return getByUserAndRange(userId: userId, from: start, to: end);
  }

  /// 查詢：月
  Future<List<PressureDataData>> getMonthly(String userId, DateTime date) {
    final start = DateTime(date.year, date.month, 1);
    final end =
        DateTime(date.year, date.month + 1, 1).subtract(Duration(seconds: 1));
    return getByUserAndRange(userId: userId, from: start, to: end);
  }

  /// 取得尚未同步的資料
  Future<List<PressureDataData>> getUnsyncedData(String userId) {
    return (db.select(db.pressureData)
          ..where(
              (tbl) => tbl.userId.equals(userId) & tbl.isSynced.equals(false)))
        .get();
  }

  /// 標記為已同步
  Future<void> markAsSynced(List<PressureDataData> list) async {
    await db.batch((batch) {
      for (final data in list) {
        batch.update(
          db.pressureData,
          const PressureDataCompanion(isSynced: Value(true)),
          where: (tbl) =>
              tbl.userId.equals(data.userId) &
              tbl.startTimeStamp.equals(data.startTimeStamp),
        );
      }
    });
  }

  /// 根據複合主鍵更新壓力資料
  Future<void> update(
      String userId, int startTimeStamp, PressureDataCompanion data) {
    return (db.update(db.pressureData)
          ..where((tbl) =>
              tbl.userId.equals(userId) &
              tbl.startTimeStamp.equals(startTimeStamp)))
        .write(data);
  }

  /// 根據複合主鍵刪除壓力資料
  Future<void> delete(String userId, int startTimeStamp) {
    return (db.delete(db.pressureData)
          ..where((tbl) =>
              tbl.userId.equals(userId) &
              tbl.startTimeStamp.equals(startTimeStamp)))
        .go();
  }

  /// 取得今日平均壓力分數
  Future<double> getTodayAverageStressScore(String userId) async {
    final list = await getDaily(userId, DateTime.now());
    if (list.isEmpty) return 0.0;

    final totalScore =
        list.fold<double>(0.0, (sum, item) => sum + item.totalStressScore);
    return totalScore / list.length;
  }

  /// 取得最新壓力數據
  Future<PressureDataData?> getLatest(String userId) async {
    final query = db.select(db.pressureData)
      ..where((tbl) => tbl.userId.equals(userId))
      ..orderBy([(tbl) => OrderingTerm.desc(tbl.startTimeStamp)])
      ..limit(1);

    return query.getSingleOrNull();
  }
}
