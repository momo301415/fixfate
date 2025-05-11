import 'package:hive/hive.dart';
import 'package:pulsedevice/core/hiveDb/body_temperature_setting.dart';

class BodyTemperatureSettingStorage {
  static final _box =
      Hive.box<BodyTemperatureSetting>('body_temperature_setting');

  static Future<void> saveUserProfile(
      String userId, BodyTemperatureSetting profile) async {
    await _box.put(userId, profile);
  }

  static BodyTemperatureSetting? getUserProfile(String userId) {
    return _box.get(userId);
  }

  static Future<void> deleteUserProfile(String userId) async {
    await _box.delete(userId);
  }

  static List<BodyTemperatureSetting> getAllProfiles() {
    return _box.values.toList();
  }

  static bool exists(String userId) {
    return _box.containsKey(userId);
  }
}
