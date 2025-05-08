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
    final lastSessionTs = await getLastTimestamp<SleepData, SleepDataData>(
      table: db.sleepData,
      userIdField: (t) => t.userId,
      userId: userId,
      timestampField: (t) => t.startTimeStamp,
    );

    // 2️⃣ 過濾出新的 Session，並升冪排序
    final newSessions = sdkData
        .where((s) => s.startTimeStamp > (lastSessionTs ?? 0))
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
