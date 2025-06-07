import 'package:hive/hive.dart';
import 'package:pulsedevice/core/hiveDb/sport_record.dart';

class SportRecordStorage {
  static final _box = Hive.box<SportRecord>('sport_record');

  static Future<void> saveUserProfile(
      String userId, SportRecord profile) async {
    await _box.put(userId, profile);
  }

  static SportRecord? getUserProfile(String userId) {
    return _box.get(userId);
  }

  static Future<void> deleteUserProfile(String userId) async {
    await _box.delete(userId);
  }

  static List<SportRecord> getAllProfiles() {
    return _box.values.toList();
  }

  static bool exists(String userId) {
    return _box.containsKey(userId);
  }
}
