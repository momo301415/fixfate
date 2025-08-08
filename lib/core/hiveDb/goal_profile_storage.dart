import 'package:hive/hive.dart';
import 'package:pulsedevice/core/hiveDb/goal_profile.dart';

class GoalProfileStorage {
  static final _box = Hive.box<GoalProfile>('goal_profile');

  static Future<void> saveUserProfile(
      String userId, GoalProfile profile) async {
    await _box.put(userId, profile);
  }

  static GoalProfile? getUserProfile(String userId) {
    return _box.get(userId);
  }

  static Future<void> deleteUserProfile(String userId) async {
    await _box.delete(userId);
  }

  static List<GoalProfile> getAllProfiles() {
    return _box.values.toList();
  }

  static bool exists(String userId) {
    return _box.containsKey(userId);
  }
}

enum GoalType {
  stepsAchieved,
  stepsPending,
  sleepAchieved,
  sleepUnachieved,
  distanceAchieved,
  distancePending,
  caloriesAchieved,
  caloriesPending,
}

class NotificationRecordStorage {
  static final _box = Hive.box<String>('notified_goals');

  /// 使用 timestamp 產生唯一 key，確保每天都能發送推播且不會重複
  /// 使用該日期 00:00:00 的 timestamp 作為 key 的一部分
  static String _key(DateTime date, GoalType type) {
    // 取得該日期的開始時間（00:00:00）
    final startOfDay = DateTime(date.year, date.month, date.day);
    final timestamp = startOfDay.millisecondsSinceEpoch;
    return "${timestamp}_${type.name}";
  }

  /// 檢查指定日期和目標類型是否已發送過通知
  static bool hasNotified(DateTime date, GoalType type) {
    final key = _key(date, type);
    final result = _box.containsKey(key);
    print(
        "🔍 hasNotified check: date=${date.toIso8601String().split('T')[0]}, key=$key, result=$result");
    return result;
  }

  /// 標記指定日期和目標類型已發送通知
  static Future<void> markNotified(DateTime date, GoalType type) async {
    final key = _key(date, type);
    await _box.put(key, "sent");
    print(
        "✅ markNotified: date=${date.toIso8601String().split('T')[0]}, key=$key");
  }

  /// 清除所有記錄（用於調試或重置）
  static Future<void> clearOldRecords() async {
    await _box.clear();
    print("🧹 已清除所有通知記錄");
  }

  /// 獲取所有通知記錄（用於調試）
  static List<String> getAllNotificationKeys() {
    return _box.keys.cast<String>().toList();
  }

  /// 檢查指定日期的所有通知記錄（用於調試）
  static Map<String, String> getNotificationsForDate(DateTime date) {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final timestamp = startOfDay.millisecondsSinceEpoch;
    final prefix = "${timestamp}_";

    final result = <String, String>{};
    for (final key in _box.keys) {
      if (key.startsWith(prefix)) {
        result[key] = _box.get(key) ?? "";
      }
    }
    return result;
  }
}
