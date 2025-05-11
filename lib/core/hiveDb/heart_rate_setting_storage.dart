import 'package:hive/hive.dart';
import 'package:pulsedevice/core/hiveDb/heart_rate_setting.dart';

class HeartRateSettingStorage {
  static final _box = Hive.box<HeartRateSetting>('heart_rate_setting');

  static Future<void> saveUserProfile(
      String userId, HeartRateSetting profile) async {
    await _box.put(userId, profile);
  }

  static HeartRateSetting? getUserProfile(String userId) {
    return _box.get(userId);
  }

  static Future<void> deleteUserProfile(String userId) async {
    await _box.delete(userId);
  }

  static List<HeartRateSetting> getAllProfiles() {
    return _box.values.toList();
  }

  static bool exists(String userId) {
    return _box.containsKey(userId);
  }
}
