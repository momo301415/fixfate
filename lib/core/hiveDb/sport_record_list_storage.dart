import 'package:hive/hive.dart';
import 'package:pulsedevice/core/hiveDb/sport_record.dart';
import 'package:pulsedevice/core/hiveDb/sport_record_list.dart';

class SportRecordListStorage {
  static final _box = Hive.box<SportRecordList>('sport_record_list');

  static Future<void> addRecords(
      String userId, List<SportRecord> newRecords) async {
    final existingList = await _box.get(userId) ?? SportRecordList(records: []);

    final combined =
        {...existingList.records, ...newRecords}.toList(); // 用 Set 去重

    // ✅ 排序也可以加上，照時間由新到舊（可選）
    combined.sort((a, b) => b.time.compareTo(a.time));

    await _box.put(userId, SportRecordList(records: combined));
  }

  static Future<List<SportRecord>> getRecords(String userId) async {
    return _box.get(userId)?.records ?? [];
  }

  static Future<void> deleteUserProfile(String userId) async {
    await _box.delete(userId);
  }

  static bool exists(String userId) {
    return _box.containsKey(userId);
  }
}
