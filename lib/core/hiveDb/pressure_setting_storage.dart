import 'package:hive/hive.dart';
import 'package:pulsedevice/core/hiveDb/pressure_setting.dart';

class PressureSettingStorage {
  static final _box = Hive.box<PressureSetting>('pressure_setting');

  static Future<void> saveUserProfile(
      String userId, PressureSetting profile) async {
    await _box.put(userId, profile);
  }

  static PressureSetting? getUserProfile(String userId) {
    return _box.get(userId);
  }

  static Future<void> deleteUserProfile(String userId) async {
    await _box.delete(userId);
  }

  static List<PressureSetting> getAllProfiles() {
    return _box.values.toList();
  }

  static bool exists(String userId) {
    return _box.containsKey(userId);
  }
}
