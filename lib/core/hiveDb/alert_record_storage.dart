import 'package:hive/hive.dart';
import 'package:pulsedevice/core/hiveDb/alert_record.dart';

class AlertRecordStorage {
  static final _box = Hive.box<AlertRecord>('alert_record');

  static Future<void> saveUserProfile(
      String userId, AlertRecord profile) async {
    await _box.put(userId, profile);
  }

  static AlertRecord? getUserProfile(String userId) {
    return _box.get(userId);
  }

  static Future<void> deleteUserProfile(String userId) async {
    await _box.delete(userId);
  }

  static List<AlertRecord> getAllProfiles() {
    return _box.values.toList();
  }

  static bool exists(String userId) {
    return _box.containsKey(userId);
  }
}
