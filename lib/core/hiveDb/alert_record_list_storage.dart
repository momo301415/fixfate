import 'package:hive/hive.dart';
import 'package:pulsedevice/core/hiveDb/alert_record.dart';
import 'package:pulsedevice/core/hiveDb/alert_record_list.dart';

class AlertRecordListStorage {
  static final _box = Hive.box<AlertRecordList>('alert_records');

  static Future<void> addRecords(
      String userId, List<AlertRecord> newRecords) async {
    final existingList = await _box.get(userId) ?? AlertRecordList(records: []);

    final combined =
        {...existingList.records, ...newRecords}.toList(); // 用 Set 去重

    // ✅ 排序也可以加上，照時間由新到舊（可選）
    combined.sort((a, b) => b.time.compareTo(a.time));

    await _box.put(userId, AlertRecordList(records: combined));
  }

  static Future<List<AlertRecord>> getRecords(String userId) async {
    return _box.get(userId)?.records ?? [];
  }

  static Future<void> deleteUserProfile(String userId) async {
    await _box.delete(userId);
  }

  static bool exists(String userId) {
    return _box.containsKey(userId);
  }

  static Future<void> markAllRecordsAsSynced(String userId) async {
    final list = await getRecords(userId);
    // ✅ 將每筆紀錄的 isSync 設為 true
    final updatedRecords = list.map((record) {
      return AlertRecord(
          time: record.time,
          synced: true,
          label: record.label,
          type: record.type,
          value: record.value,
          unit: record.unit);
    }).toList();

    // ✅ 更新整筆資料
    await _box.put(userId, AlertRecordList(records: updatedRecords));
  }
}
