import 'package:hive/hive.dart';
import 'package:pulsedevice/core/hiveDb/blood_oxygen_setting.dart';

class BloodOxygenSettingStorage {
  static final _box = Hive.box<BloodOxygenSetting>('blood_oxygen_setting');

  static Future<void> saveUserProfile(
      String userId, BloodOxygenSetting profile) async {
    await _box.put(userId, profile);
  }

  static BloodOxygenSetting? getUserProfile(String userId) {
    return _box.get(userId);
  }

  static Future<void> deleteUserProfile(String userId) async {
    await _box.delete(userId);
  }

  static List<BloodOxygenSetting> getAllProfiles() {
    return _box.values.toList();
  }

  static bool exists(String userId) {
    return _box.containsKey(userId);
  }
}
