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
