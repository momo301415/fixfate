import 'package:hive/hive.dart';
import 'package:pulsedevice/core/hiveDb/user_profile.dart';

class UserProfileStorage {
  static final _box = Hive.box<UserProfile>('user_profile');

  static Future<void> saveUserProfile(
      String userId, UserProfile profile) async {
    await _box.put(userId, profile);
  }

  static UserProfile? getUserProfile(String userId) {
    return _box.get(userId);
  }

  static Future<void> deleteUserProfile(String userId) async {
    await _box.delete(userId);
  }

  static List<UserProfile> getAllProfiles() {
    return _box.values.toList();
  }

  static bool exists(String userId) {
    return _box.containsKey(userId);
  }
}
