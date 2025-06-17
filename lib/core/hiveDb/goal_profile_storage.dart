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

  /// 產生一個當天的唯一 key，例如：2025-06-15_stepsAchieved
  static String _key(DateTime date, GoalType type) {
    final day = "${date.year}-${date.month}-${date.day}";
    return "${day}_${type.name}";
  }

  static bool hasNotified(DateTime date, GoalType type) {
    return _box.containsKey(_key(date, type));
  }

  static Future<void> markNotified(DateTime date, GoalType type) async {
    await _box.put(_key(date, type), "sent");
  }

  /// 可以每日凌晨清除所有記錄（非必要，但可防 Hive 累積）
  static Future<void> clearOldRecords() async {
    await _box.clear();
  }
}
