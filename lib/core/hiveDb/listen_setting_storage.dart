import 'package:hive/hive.dart';
import 'package:pulsedevice/core/hiveDb/listen_setting.dart';

class ListenSettingStorage {
  static final _box = Hive.box<ListenSetting>('Listen_setting');

  static Future<void> saveUserProfile(
      String userId, ListenSetting profile) async {
    await _box.put(userId, profile);
  }

  static ListenSetting? getUserProfile(String userId) {
    return _box.get(userId);
  }

  static Future<void> deleteUserProfile(String userId) async {
    await _box.delete(userId);
  }

  static List<ListenSetting> getAllProfiles() {
    return _box.values.toList();
  }

  static bool exists(String userId) {
    return _box.containsKey(userId);
  }
}
