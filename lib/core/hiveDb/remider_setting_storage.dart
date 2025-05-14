import 'package:hive/hive.dart';
import 'package:pulsedevice/core/hiveDb/remider_setting.dart';

class RemiderSettingStorage {
  static final _box = Hive.box<RemiderSetting>('remider_setting');

  static Future<void> saveUserProfile(
      String userId, RemiderSetting profile) async {
    await _box.put(userId, profile);
  }

  static RemiderSetting? getUserProfile(String userId) {
    return _box.get(userId);
  }

  static Future<void> deleteUserProfile(String userId) async {
    await _box.delete(userId);
  }

  static List<RemiderSetting> getAllProfiles() {
    return _box.values.toList();
  }

  static bool exists(String userId) {
    return _box.containsKey(userId);
  }
}
